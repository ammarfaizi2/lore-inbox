Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWBSX7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWBSX7i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWBSX7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:59:38 -0500
Received: from digitalimplant.org ([64.62.235.95]:53448 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932450AbWBSX7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:59:38 -0500
Date: Sun, 19 Feb 2006 15:59:25 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>,
       "" <linux-pm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power
 states in sysfs interface
In-Reply-To: <20060218155543.GE5658@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
 <20060218155543.GE5658@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 18 Feb 2006, Pavel Machek wrote:

> Hi!
>
> > Fix the per-device state file to respect the actual state that
> > is reported by the device, or written to the file.
>
> Can we let "state" file die? You actually suggested that at one point.
>
> I do not think passing states in u32 is good idea. New interface that passes
> state as string would probably be better.

Yup, in the future that will be better. For now, let's work with what we
got and fix 2.6.16 to be compatible with previous versions..

Thanks,


	Pat

