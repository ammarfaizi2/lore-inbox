Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965429AbWJBVxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965429AbWJBVxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965439AbWJBVxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:53:48 -0400
Received: from mail119.messagelabs.com ([216.82.241.179]:39349 "HELO
	mail119.messagelabs.com") by vger.kernel.org with SMTP
	id S965429AbWJBVxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:53:47 -0400
X-VirusChecked: Checked
X-Env-Sender: preece@urbana.css.mot.com
X-Msg-Ref: server-3.tower-119.messagelabs.com!1159826025!8468399!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [129.188.136.8]
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Mon, 2 Oct 2006 16:53:44 -0500 (CDT)
Message-Id: <200610022153.k92Lri6C011458@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: shd@zakalwe.fi
CC: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
In-reply-to: Heikki Orsila's message of Mon, 2 Oct 2006 23:44:25 +0300
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



| From: Heikki Orsila<shd@zakalwe.fi>
| 
| On Mon, Oct 02, 2006 at 01:58:33PM -0500, Scott E. Preece wrote:
| > It also helps with static analysis tools.
| 
| I'd say those analysis tools are pretty useless if they can not handle 
| trivial cases like this.
| 
| > CodingStyle seems to
| > be silent on the point, but points to Kernighan and Ritchie, who say
| > "These initializations are actually unnecessary, since all are zero, but
| > it's a good idea to make them explicit anyway."
| 
| It was a local variable. They are not autoinitialised. Are you perhaps 
| mixing this with statics and globals?
---

Indeed - I answered too quickly.

However, as noted, there's no practical cost to including the
initializations and some of us do work in places where it's normallly
required.

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com


