Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbREPPPa>; Wed, 16 May 2001 11:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbREPPPU>; Wed, 16 May 2001 11:15:20 -0400
Received: from geos.coastside.net ([207.213.212.4]:47830 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261984AbREPPPO>; Wed, 16 May 2001 11:15:14 -0400
Mime-Version: 1.0
Message-Id: <p05100345b72848dc8dea@[207.213.214.37]>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it>
Date: Wed, 16 May 2001 08:14:40 -0700
To: "Chemolli Francesco (USI)" <ChemolliF@GruppoCredit.it>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: RE: LANANA: To Pending Device Number Registrants
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:56 AM +0200 2001-05-16, Chemolli Francesco (USI) wrote:
>We could do something like baptizing disks.. Fix some location
>(i.e. the absolutely last sector of the disk or the partition table or
>whatever) and store there some 32-bit ID
>(could be a random number, a progressive number, whatever).

Most of these solutions (and RAID IDs and UUIDs) don't completely 
solve the problem; they just push it to a different time: how do you 
talk about a new disk, or a new RAID array, or a moved disk? And what 
about removable media (not neglecting the possibility of multiple 
drives)? Removable media from another OS? Shared drives?

Not that this kind of "firm" ID might not be an improvement, or at 
least a good sanity check.

[Side question, not original with me: why isn't all this a 2.5 discussion?]
-- 
/Jonathan Lundell.
