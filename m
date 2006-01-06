Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWAFAbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWAFAbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWAFAbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:31:20 -0500
Received: from motgate8.mot.com ([129.188.136.8]:11165 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S932325AbWAFAbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:31:18 -0500
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Thu, 5 Jan 2006 18:31:11 -0600 (CST)
Message-Id: <200601060031.k060VBDV000727@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: mochel@digitalimplant.org
CC: scott.preece@motorola.com, pavel@ucw.cz, stern@rowland.harvard.edu,
       akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-reply-to: Patrick Mochel's message of Thu, 5 Jan 2006 16:02:29 -0800 (PST)
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK - sorry, my misparsing of what you asked. I agree that wakeup would
always be caused by some single device, not by multiple devices.

scott

| From mochel@digitalimplant.org Thu Jan  5 18:04:42 2006
| Date: Thu, 5 Jan 2006 16:02:29 -0800 (PST)
| From: Patrick Mochel<mochel@digitalimplant.org>
| cc: Pavel Machek<pavel@ucw.cz>, Alan Stern<stern@rowland.harvard.edu>,
| 
| 
| On Thu, 5 Jan 2006, Preece Scott-PREECE wrote:
| 
| > This is, of course, in an embedded framework rather than a desktop
| > framework - we suspend and wakeup automatically, not via user
| > intervention. Answering a question asked in another piece of mail, we
| > have roughly a dozen different devices that cause the system to wakeup -
| > keypad press, touchscreen touch, flip open/close, etc.
| 
| Hmm, it would be nice if that comment was in reply to the email in which
| it came. At least if it was in the same thread..
| 
| Many systems have > 1 _possible_ wakeup devices (keyboard, touchscreen,
| lid, etc). You implied that when a system wakes up, there could be > 1
| device that actually woke the system up, which is in direct conflict with
| what I've always assumed - that when a system wakes up, it is caused by a
| single device (and if there were multiple events, like a key press *and* a
| mouse movement, it's doesn't really matter)..
| 
| Thanks,
| 
| 
| 	Patrick
| 
| 

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com


