Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbTCXX5t>; Mon, 24 Mar 2003 18:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbTCXX5s>; Mon, 24 Mar 2003 18:57:48 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:50068 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261271AbTCXX5r>; Mon, 24 Mar 2003 18:57:47 -0500
Subject: Re: CONFIG_VT_CONSOLE in 2.5.6x ?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1048548310.3388.7.camel@tiger>
References: <1048546447.3058.3.camel@tiger>
	 <33453.4.64.238.61.1048547120.squirrel@www.osdl.org>
	 <1048548310.3388.7.camel@tiger>
Content-Type: text/plain
Organization: 
Message-Id: <1048550922.27811.16.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 25 Mar 2003 01:08:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 00:25, Louis Garcia wrote:
> Well I can't find it there. I have a 2.5.65 tree and under character
> devices I have
> 
> [ ] Non-standard serial port support
>     Serial drivers --->
> [ ] Unix98 PTY support
> (2048) Maximum number of Unix98 PTYs in use (0-2048)
> [ ] Parallel Printer support 
> 
> 
> I see nothing for Virtual terminal in this sub-menu. Does this depend on
> another option?

Yes... Make sure "Input device support" is selected (Y), and also, check
that you've enabled support for the proper keyboard (if you plan to use
the console for entering commands).

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

