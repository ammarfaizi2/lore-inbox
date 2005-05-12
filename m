Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVELFBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVELFBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 01:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVELFBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 01:01:09 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:49093 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261249AbVELFBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 01:01:06 -0400
Message-ID: <4282E3C0.8080604@imag.fr>
Date: Thu, 12 May 2005 07:04:00 +0200
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>,
       linux-kernel@vger.kernel.org, industeqsite@industeqsite.com
Subject: Re: remote keyboard
References: <Pine.LNX.4.60.0505121017090.31256@lantana.cs.iitm.ernet.in>
In-Reply-To: <Pine.LNX.4.60.0505121017090.31256@lantana.cs.iitm.ernet.in>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P.Manohar wrote:
> 
> " I am planning to have remote keyboard to control the operations on a
>  particular target. To explain in detail, I will have a PC with keyboard,
>  mouse etc and this PC will be connected to another PC(Remote) via
> Ethernet.
> Instead of using the local keyboard input, I want sent the keyboard keys
> from the remote system (another PC via Ethernet) and use it as if it from
>  the local keyboard.
> 
> My Plan
>  I am planning to use the Linux keyboard driver and read the keyboard
> buffer
> from the remote PC and send it to the target PC, and in the target PC
>  whatever the key code I have received through the Ethernet I will put it
> into the local keyboard buffer using the Linux keyboard driver IOCTLs.
> 
>  Can anybody tell me is this acceptable "
> 
> 
> Hai,
>    The above message appeared in kernel-mailing list,
>  I am also involved in the same problem.
> How to put characters into keyboard buffer using the Linux keyboard
> driver IOCTLs?
> 
> If anybody knows about it please guide me.

are you using a graphical (Xwindow) application ?
in that case there is absolutely no point in doing that kind of horrible
hack, as the XWindow System is network transparent, that is, you can run
the application on machine A, and have it display and be controlled on
machine B
you can even use the ssh secure shell to securely do so, in an encrypted
manner.

