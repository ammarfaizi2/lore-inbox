Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945922AbWBONf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945922AbWBONf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbWBONf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:35:27 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:18638 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1945922AbWBONf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:35:26 -0500
Date: Wed, 15 Feb 2006 14:35:23 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Ross Vandegrift <ross@jose.lug.udel.edu>
Cc: Marc Koschewski <marc@osknowledge.org>, Christian <christiand59@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060215133523.GA6628@stiffy.osknowledge.org>
References: <20060214135016.GC10701@stusta.de> <200602141659.40176.christiand59@web.de> <20060214164002.GC5905@stiffy.osknowledge.org> <20060214184708.GA29656@lug.udel.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214184708.GA29656@lug.udel.edu>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc3-marc-g30379440-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ross Vandegrift <ross@lug.udel.edu> [2006-02-14 13:47:08 -0500]:

> On Tue, Feb 14, 2006 at 05:40:03PM +0100, Marc Koschewski wrote:
> > Is that maybe dependant on _what_ version of Samba is running on the receiving
> > end?
> 
> I've seen it copying to Windows 2k3.  Only uploading large files, and
> it's not every time.  I'd say 50% of the time, my box freezes when
> copying something around 100MiB or larger.
> 
> IIRC, my workstation at the office is running 2.6.15.1 or .4.

I moved to CIFS because SMB didn't work well for me, as well as did NFS. Both
seems to stall in a way, I could never really reproduce. But CIFS is very stable
over here. Never ever had a problem with it, whereas both NFS and SMB are likely
to cause trouble at least once a week. Without log records, without any chance
of recovery. Mostly hard-freezes.

Marc
