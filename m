Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWBMRQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWBMRQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWBMRQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:16:21 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:14053 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S932286AbWBMRQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:16:19 -0500
From: Luke-Jr <luke@dashjr.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 17:16:19 +0000
User-Agent: KMail/1.9
Cc: fmalita@gmail.com, tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de, diegocg@gmail.com
References: <mj+md-20060209.173519.1949.atrey@ucw.cz> <43F0B663.9040001@gmail.com> <43F0B731.nailMCT1Z7ZG8@burner>
In-Reply-To: <43F0B731.nailMCT1Z7ZG8@burner>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131716.21790.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 16:43, Joerg Schilling wrote:
> It seems that this "discussion" is missong new ideas and I believe it's
> best to stop any conversation that does not introduce new ideas.
>
> I mentioned the two most important Linux Bugs to fix.
>
> Let us continue after there is at least a hint that leads to a possible
> fix for these bugs.
>
> It makes no sense to waste my time while it is obvious that the Linux
> kernel folks are completely missing any will to fix their bugs.

I think the general consensus from kernel developers and cdrecord users alike 
is that the only logical way to refer to devices in Linux is via /dev/* and 
any other method is broken and illogical.

If you want stable b,t,l junk, submit a clean patch for Linux yourself. Either 
way, 99.99% of cdrecord *users* want to use /dev/cdrom whether b,t,ls are 
stable or not. The code to do the latter is already written, working, and 
well-tested-- you just need to drop an artificial warning.
