Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRCPApg>; Thu, 15 Mar 2001 19:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbRCPAp0>; Thu, 15 Mar 2001 19:45:26 -0500
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:61622 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129436AbRCPApT>; Thu, 15 Mar 2001 19:45:19 -0500
Message-ID: <3AB163F4.EB7EF5E2@didntduck.org>
Date: Thu, 15 Mar 2001 19:53:08 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Shane Y. Gibson" <sgibson@digitalimpact.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops 0000 and 0002 on dual PIII 750 2.4.2 SMP platform
In-Reply-To: <3AB13120.AE7187B@digitalimpact.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shane Y. Gibson" wrote:
> 
> All,
> 
> I just compiled 2.4.2 and installed it on a otherwise stock
> Redhat 7.0 platform.  The system is a SuperMicro PIIISME,
> running dual PIII 750s, with 256 cache.  It appears that about
> every 10 to 18 hours, the system is panicing, and freezing
> up.  The first time, I got an oops 0000, the second time an
> oops 0002.  Both crashes have occured only when the systems is
> at 100% cpu utlization; processing several hundred MRTG
> indexmaker operations.
> 
> I ran ksymoops on both outputs, and the results are pasted
> below.  Note, I compiled the kernel without loadable module
> support.  Please let me know if there is anything else I can
> do/provide to help.  Unfortunately, the second didn't output
> enough for ksymoops to extract anything usefull.
> 
> v/r
> Shane
> 
> Code;  00000000 Before first symbol
>    0:   0f 0b                     ud2a

There should be a line just before the oops saying "kernel BUG at..."

--
					Brian Gerst
