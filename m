Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319345AbSIKV0M>; Wed, 11 Sep 2002 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319346AbSIKV0M>; Wed, 11 Sep 2002 17:26:12 -0400
Received: from e.kth.se ([130.237.48.5]:26635 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S319345AbSIKV0L>;
	Wed, 11 Sep 2002 17:26:11 -0400
To: Phil Stracchino <alaric@babcom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM driver does not support Linux partition tables
References: <20020904181952.GA1158@babylon5.babcom.com>
	<1031182512.3017.139.camel@irongate.swansea.linux.org.uk>
	<20020911211959.GA31724@babylon5.babcom.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 11 Sep 2002 23:30:49 +0200
In-Reply-To: Phil Stracchino's message of "Wed, 11 Sep 2002 17:19:59 -0400"
Message-ID: <yw1xr8g0kyd2.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Stracchino <alaric@babcom.com> writes:

>  
> A deficiency in the Linux CDROM driver was just brought to my attention.
> Even on a kernel configured with support for UFS and Sun partition
> tables, it doesn't appear to be possible to mount any but the first
> slice of a Sun CDROM containing multiple slices.  Essentially, it seems
> that Solaris partition table support doesn't trickle down to the CDROM
> driver.
> 
> Is this something that's supposed to happen, and is there a reason why
> it's not supported, or is it simply that no-one has asked for it to be
> supported and/or no-one has gotten around to implementing it because of 
> lack of demand?
> 
> (The particular case in which this came up is someone who has a Sun box
> without a CDROM drive in it, and wants to use a Linux box as a jumpstart
> server, but can't because the Linux box can't read beyond the first
> slice on the CD.)

Can the disk be copied to a file or hard disk and mounted there?

-- 
Måns Rullgård
mru@users.sf.net
