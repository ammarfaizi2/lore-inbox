Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbTAGKXI>; Tue, 7 Jan 2003 05:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267366AbTAGKXI>; Tue, 7 Jan 2003 05:23:08 -0500
Received: from kerberos.ncsl.nist.gov ([129.6.57.216]:39810 "EHLO
	kerberos.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S267359AbTAGKXH>; Tue, 7 Jan 2003 05:23:07 -0500
Date: Tue, 7 Jan 2003 05:31:46 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030107053146.A16578@kerberos.ncsl.nist.gov>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <17360000.1041899978@localhost.localdomain>; from andrew@indranet.co.nz on Tue, Jan 07, 2003 at 01:39:38PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 01:39:38PM +1300, Andrew McGregor wrote:
> Ethernet and TCP were both designed to be cheap to evaluate, not the 
> absolute last word in integrity.  There is a move underway to provide an 
> optional stronger TCP digest for IPv6, and if used with that then there is 
> no need for the iSCSI digest.  Otherwise, well, play dice with the data. 
> Loaded in your favour, but still dice.

Ethernet's checksum is a standard crc32, with all the usual good
properties and, at least on FE and lower, 1500bytes max of payload.
So it's quite reasonable.  TCP's checksum, though, is crap.

I'm not entirely sure how crc32 would behave on jumbo frames.

  OG.
