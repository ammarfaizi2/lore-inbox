Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSGCSMD>; Wed, 3 Jul 2002 14:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSGCSMC>; Wed, 3 Jul 2002 14:12:02 -0400
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:1664 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S317115AbSGCSMB>; Wed, 3 Jul 2002 14:12:01 -0400
Date: Wed, 3 Jul 2002 14:19:29 -0400
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703181929.GA6240@lnuxlab.ath.cx>
References: <20020703022051.GA2669@lnuxlab.ath.cx> <3D226E86.695D27F3@zip.com.au> <20020703174340.GL22762@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703174340.GL22762@louise.pinerecords.com>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 07:43:40PM +0200, Tomas Szepe wrote:
> Checking out $(smartctl -l /dev/hda) might be advisable too.

# smartctl -l /dev/hda
SMART Error Log:
SMART Error Logging Version: 1
Error Log Data Structure Pointer: 05
ATA Error Count: 1038
Non-Fatal Count: 0

Error Log Structure 1:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 08   00   02   71   01   01    e0   c8     54770
 08   00   02   75   01   01    e0   c8     54770
 08   00   02   79   01   01    e0   c8     54770
 08   d0   01   00   4f   c2    e0   b0     54770
 08   d1   01   01   4f   c2    e0   b0     54770
 00   04   01   0b   4f   c2    e0   51     1608563

Error Log Structure 2:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 08   00   0a   03   51   00    e0   ca     54728
 08   00   0a   9b   6b   00    e0   ca     54728
 08   00   14   cd   0c   00    e0   ca     54728
 08   00   02   e1   0c   00    e0   ca     54728
 08   d0   01   00   4f   c2    e0   b0     54729
 00   04   01   0b   4f   c2    e0   51     1608522

Error Log Structure 3:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 08   00   02   4b   00   07    e0   ca     54812
 08   00   02   5d   00   07    e0   ca     54812
 08   00   02   4f   02   07    e0   ca     54812
 08   00   04   41   00   00    e0   ca     54812
 08   00   01   01   00   00    a0   a1     54823
 00   04   01   01   00   00    a0   51     1608551

Error Log Structure 4:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 08   00   02   4b   00   07    e0   ca     54812
 08   00   02   5d   00   07    e0   ca     54812
 08   00   02   4f   02   07    e0   ca     54812
 08   00   04   41   00   00    e0   ca     54812
 08   00   05   01   00   00    a0   a1     54867
 00   04   05   01   00   00    a0   51     1608529

Error Log Structure 5:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 08   d2   00   01   4f   c2    a0   b0     54867
 08   00   01   01   00   00    a0   c4     54867
 08   03   0c   01   00   00    a0   ef     54867
 08   03   44   01   00   00    a0   ef     54867
 08   03   44   01   00   00    a0   22     54867
 00   04   44   01   00   00    a0   51     1608529

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
