Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVAAVbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVAAVbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 16:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVAAVbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 16:31:40 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:54638 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261168AbVAAVbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 16:31:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Sat, 1 Jan 2005 16:31:36 -0500
User-Agent: KMail/1.6.2
Cc: Roey Katz <roey@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501011631.36884.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 January 2005 03:27 am, Roey Katz wrote:
> Hello,
> 
> Upon bootup, kernels 2.6.9 and 2.6.10 do not respond to keyboard input 
> (e.g., I enter a few chars at the prompt but I see nothing).  I can SSH 
> into the system, though, but I don't know what to do from there. I used 
> the .config from my 2.6.7 kernel, which works properly (I did run 'make 
> oldconfig'). In all .config files, I have the following:
> 
>   CONFIG_INPUT_KEYBOARD=y
>   CONFIG_KEYBOARD_ATKBD=y
>   # CONFIG_KEYBOARD_SUNKBD is not set
>   # CONFIG_KEYBOARD_LKKBD is not set
>   # CONFIG_KEYBOARD_XTKBD is not set
>   # CONFIG_KEYBOARD_NEWTON is not set
> 
> So that looks OK... I also SSH'd into the system, did a 'cat 
> /dev/input/event0' and typed on the system's keyboard, but 'cat' 
> remained silent. Perhaps there is a better way to see if the system is 
> recognizing the keyboard input (or even seeing the keyboard 
> itself).  I give up.. what am I doing wrong???
> 

What does /proc/bus/input/devices show? Do you have Synaptics touchpad/
driver in your box?

-- 
Dmitry
