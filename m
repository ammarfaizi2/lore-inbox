Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265952AbTFSVFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbTFSVFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:05:18 -0400
Received: from diesel.grid4.com ([208.49.116.17]:37765 "EHLO diesel.grid4.com")
	by vger.kernel.org with ESMTP id S265952AbTFSVEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:04:51 -0400
Date: Thu, 19 Jun 2003 17:18:49 -0400
From: Paul <set@pobox.com>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 packet writing?
Message-ID: <20030619211849.GB2297@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	John Goerzen <jgoerzen@complete.org>, linux-kernel@vger.kernel.org
References: <87d6hczgiu.fsf@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6hczgiu.fsf@complete.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Goerzen <jgoerzen@complete.org>, on Tue Jun 17, 2003 [01:48:57 PM] said:
> Hello,
> 
> I've been using the packet writing patches floating around for some
> time, and find them very useful.  I have modified slightly a recent
> one to work with 2.4.21-rc8.  It worked with the IDE CD-ROM driver
> (that is, /dev/hdc), but with the ide-scsi driver at /dev/scd0, it
> would read but threw up a write error every time a modification was
> attempted.
> 
> Has anyone made a packet writing patch compatible with 2.4.21 that
> works with ide-scsi?
> 
> My workaround to date has been to unload the ide-scsi module and
> insert the IDE cdrom module when I want to use packet writing, and do
> the reverse when I want to use cdrecord.  It's quite annoying and I'd
> rather just use one device the whole time.
> 
> Thanks,
> John Goerzen
> 

	Hi;

	Peter Osterlund posted this to the
packet-writing@suse.com mailing list. Im using it, with ide-scsi.
(no modules) [barely tested, though]

http://w1.894.telia.com/~u89404340/patches/packet/2.4/packet-2.4.21.patch.bz2

Paul
set@pobox.com
