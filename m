Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWBRRPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWBRRPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWBRRPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:15:32 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:56740 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932091AbWBRRPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:15:31 -0500
Date: Sat, 18 Feb 2006 12:15:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-reply-to: <20060218120617.GA911@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Bill Davidsen <davidsen@tmr.com>,
       Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Message-id: <200602181215.30277.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <43F641A2.50200@tmr.com>
 <20060218120617.GA911@infradead.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 07:06, Christoph Hellwig wrote:

cat /proc/sys/dev/cdrom/info
CD-ROM information, Id: cdrom.c 3.20 2003/12/17

drive name:             hdc
drive speed:            48
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         1
Can write CD-RW:        1
Can read DVD:           1
Can write DVD-R:        1
Can write DVD-RAM:      0
Can read MRW:           1
Can write MRW:          1
Can write RAM:          1

But I fail to see where this would help to 'find' the right device to 
write to, other than the obvious prefixing of '/dev/' to $drive name.  
We already knew that, and in fact it works very well. Please explain to 
Joerg in one syllable words he might, if he wanted to, understand.

Also, I'm fuzzy about the last 3, so defining those might help me 
understand.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
