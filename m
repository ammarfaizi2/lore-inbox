Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313732AbSDPQD5>; Tue, 16 Apr 2002 12:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313734AbSDPQDS>; Tue, 16 Apr 2002 12:03:18 -0400
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:11855
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313738AbSDPQBz>; Tue, 16 Apr 2002 12:01:55 -0400
Message-Id: <200204161601.g3GG1nP03345@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH: NEW ARCHITECTURE FOR 2.5.8] support for NCR voyager (3/4/5xxx
 series)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Apr 2002 11:01:49 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMP (and UP) support for voyager which is an (up to 32 way) 
SMP microchannel non-PC architecture.

The patch is in two parts:  The i386 sub-architecture split is 
separated from the addition of the voyager components

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.8.diff (269k)
http://www.hansenpartnership.com/voyager/files/voyager-2.5.8.diff (150k)

(The split diff is pretty huge because it's actually moving files about).  You 
must apply the split diff before applying the voyager one.

These two patches are also available as separate bitkeeper trees:

http://linux-voyager.bkbits.net/voyager-2.5
http://linux-voyager.bkbits.net/arch-split-2.5

James Bottomley

