Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVAAI2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVAAI2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 03:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVAAI2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 03:28:32 -0500
Received: from mx.freeshell.org ([192.94.73.21]:47296 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262195AbVAAI2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 03:28:30 -0500
Date: Sat, 1 Jan 2005 08:27:45 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Message-ID: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Upon bootup, kernels 2.6.9 and 2.6.10 do not respond to keyboard input 
(e.g., I enter a few chars at the prompt but I see nothing).  I can SSH 
into the system, though, but I don't know what to do from there. I used 
the .config from my 2.6.7 kernel, which works properly (I did run 'make 
oldconfig'). In all .config files, I have the following:

  CONFIG_INPUT_KEYBOARD=y
  CONFIG_KEYBOARD_ATKBD=y
  # CONFIG_KEYBOARD_SUNKBD is not set
  # CONFIG_KEYBOARD_LKKBD is not set
  # CONFIG_KEYBOARD_XTKBD is not set
  # CONFIG_KEYBOARD_NEWTON is not set

So that looks OK... I also SSH'd into the system, did a 'cat 
/dev/input/event0' and typed on the system's keyboard, but 'cat' 
remained silent. Perhaps there is a better way to see if the system is 
recognizing the keyboard input (or even seeing the keyboard 
itself).  I give up.. what am I doing wrong???


Thanks,

Roey Katz 
PS: please CC responses to roey at freeshell dot org, thanks!
