Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267915AbTAHTCh>; Wed, 8 Jan 2003 14:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbTAHTCh>; Wed, 8 Jan 2003 14:02:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30212 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267915AbTAHTCf>; Wed, 8 Jan 2003 14:02:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Date: 8 Jan 2003 11:10:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <avht3k$qpo$1@cesium.transmeta.com>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <20030107053146.A16578@kerberos.ncsl.nist.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030107053146.A16578@kerberos.ncsl.nist.gov>
By author:    Olivier Galibert <galibert@pobox.com>
In newsgroup: linux.dev.kernel
>
> On Tue, Jan 07, 2003 at 01:39:38PM +1300, Andrew McGregor wrote:
> > Ethernet and TCP were both designed to be cheap to evaluate, not the 
> > absolute last word in integrity.  There is a move underway to provide an 
> > optional stronger TCP digest for IPv6, and if used with that then there is 
> > no need for the iSCSI digest.  Otherwise, well, play dice with the data. 
> > Loaded in your favour, but still dice.
> 
> Ethernet's checksum is a standard crc32, with all the usual good
> properties and, at least on FE and lower, 1500bytes max of payload.
> So it's quite reasonable.  TCP's checksum, though, is crap.
> 
> I'm not entirely sure how crc32 would behave on jumbo frames.
> 

AUTODIN-II CRC32 (the one used by Ethernet) is stable up to 11454
bytes.  The jumbo frame size was chosen as the largest multiple of the
standard IP payload size to fit within this number.

	-hpa







-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
