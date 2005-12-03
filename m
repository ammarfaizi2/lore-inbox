Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVLCVhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVLCVhV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVLCVhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:37:21 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:43271 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751282AbVLCVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:37:20 -0500
Message-ID: <4392100E.6070303@superbug.demon.co.uk>
Date: Sat, 03 Dec 2005 21:37:18 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "M." <vo.sinh@gmail.com>
CC: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>	 <20051203201945.GA4182@kroah.com> <f0cc38560512031304n4fcb1c3dn717e4a8e80fcbacd@mail.gmail.com>
In-Reply-To: <f0cc38560512031304n4fcb1c3dn717e4a8e80fcbacd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M. wrote:
> 
> Yes but not home users with relatively new/bleeding edge hardware or
> small projects writing for example a wifi driver or a security patch
> or whatever without full time commitment to tracking kernel changes.
> 

If there are "small projects writing" their own wifi driver, they should 
try to get it included in the kernel ASAP. Then they won't have to track 
the changes, as the person making the changes will automatically change 
their little driver to keep it working after the changes.
Drivers very rarely impact the stability of the rest of the kernel.
It initially gets added as "EXPERIMENTAL" so the user can choose whether 
to even use it or not.

All it takes is for the "small project" to build their own git tree, and 
then ask the Linus or Andrew to pull it. It should get added pretty 
easily, so long as the code looks pretty. :-)
It is really that simple. There is no logical reason for any external 
driver not to be added into the main kernel, so why do people not want 
to add them?

James
