Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269630AbRHHXVO>; Wed, 8 Aug 2001 19:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269632AbRHHXVE>; Wed, 8 Aug 2001 19:21:04 -0400
Received: from femail31.sdc1.sfba.home.com ([24.254.60.21]:27354 "EHLO
	femail31.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269631AbRHHXUw>; Wed, 8 Aug 2001 19:20:52 -0400
Message-ID: <3B71C9FF.B2E0979C@didntduck.org>
Date: Wed, 08 Aug 2001 19:23:43 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Carl-Johan Kjellander <carljohan@kjellander.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 386 boot problems with 2.4.7 and 2.4.7-ac9
In-Reply-To: <3B706C11.7010100@kjellander.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Johan Kjellander wrote:
> 
> I have an old 386 which ran 2.4.3 just fine. Last night i tried
> to upgrade it but it didnt work at all.
> 
> I compiled a stock 2.4.7, and since I had seen some postings on
> that egcs-2.91.66 didn't compile 2.4.7 I switched to gcc-2.96-85.
> The only thing I added to the kernel was ISAPNP support.
> 
> The 2.4.7 kernel seems to boot fine, no error messages or nothing,
> but it won't start init. The last line is:
> 
>    Freeing unused kernel memory: 52K freed
> 
> And then it just stops. The kernel is still resonsive but init won't
> start. Shift-PageUp still works. SysRQ shows that the EIP almost
> always is on the same spot in schedule. I tried init=/bin/sh but
> the boot stops at the same place every time.
> 
> Then I tried 2.4.7-ac9, same configuration, but that kernel panics.

Are you using math emulation?  If so there was a bug fixed in the
2.4.8-pre kernels.

--
						Brian Gerst
