Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVI2Xs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVI2Xs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVI2Xs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:48:59 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:44944 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751392AbVI2Xs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:48:58 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
Date: Fri, 30 Sep 2005 09:48:43 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <79voj1d26bdhdiokduhlairh7jrsdrvmaj@4ax.com>
References: <20050929143732.59d22569.akpm@osdl.org> <6bffcb0e05092915472f8589eb@mail.gmail.com> <433C765D.9020205@gmail.com> <20050929162507.3efb8b1a.akpm@osdl.org>
In-Reply-To: <20050929162507.3efb8b1a.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005 16:25:07 -0700, Andrew Morton <akpm@osdl.org> wrote:

>"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>>
>> Michal Piotrowski wrote:
>> > Hi,
>> > 
>> > On 29/09/05, Andrew Morton <akpm@osdl.org> wrote:
>> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
>> >>
>> >> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
>> > 
>> > VESA VGA graphics support doesn't work with nvidia card (black
>> > screen). (I know there is nvidia frame buffer support, but VESA VGA
>> > works for me on current git).
>> > 
>> > #
>> > # Console display driver support
>> > #
>> > CONFIG_VGA_CONSOLE=y
>> > CONFIG_DUMMY_CONSOLE=y
>> > # CONFIG_FRAMEBUFFER_CONSOLE is not set
>> 
>> Set this to y.
>> 
>
>Was this a slipup by Michal, or did we do something to fool `make oldconfig'?

grant@sempro:/opt/linux/linux-2.6.14-rc2-mm2a$ grep CONFIG_FRAMEBUFFER_CONSOLE .config
CONFIG_FRAMEBUFFER_CONSOLE=y

oldconfig okay here
Grant.

