Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319339AbSIKVPP>; Wed, 11 Sep 2002 17:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319341AbSIKVPP>; Wed, 11 Sep 2002 17:15:15 -0400
Received: from [208.34.239.54] ([208.34.239.54]:19137 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S319339AbSIKVPO>; Wed, 11 Sep 2002 17:15:14 -0400
Date: Wed, 11 Sep 2002 17:19:59 -0400
From: Phil Stracchino <alaric@babcom.com>
To: linux-kernel@vger.kernel.org
Subject: CDROM driver does not support Linux partition tables
Message-ID: <20020911211959.GA31724@babylon5.babcom.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020904181952.GA1158@babylon5.babcom.com> <1031182512.3017.139.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031182512.3017.139.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-ICBM: 35.6880N 77.4375W
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
X-UCE-Policy: No unsolicited commercial email is accepted at this site.  All senders of UCE will be immediately and permanently blocked.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
A deficiency in the Linux CDROM driver was just brought to my attention.
Even on a kernel configured with support for UFS and Sun partition
tables, it doesn't appear to be possible to mount any but the first
slice of a Sun CDROM containing multiple slices.  Essentially, it seems
that Solaris partition table support doesn't trickle down to the CDROM
driver.

Is this something that's supposed to happen, and is there a reason why
it's not supported, or is it simply that no-one has asked for it to be
supported and/or no-one has gotten around to implementing it because of 
lack of demand?

(The particular case in which this came up is someone who has a Sun box
without a CDROM drive in it, and wants to use a Linux box as a jumpstart
server, but can't because the Linux box can't read beyond the first
slice on the CD.)



-- 
 *********  Fight Back!  It may not be just YOUR life at risk.  *********
 :phil stracchino : unix ronin : renaissance man : mystic zen biker geek:
 : alaric@babcom.com   :::   alaric@geeksnet.com   :::    phil@latt.net :
 :  2000 CBR929RR, 1991 VFR750F3 (foully murdered), 1986 VF500F (sold)  :
 :    Linux Now! ...because friends don't let friends use Microsoft.    :
