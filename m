Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSFDNAT>; Tue, 4 Jun 2002 09:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSFDNAS>; Tue, 4 Jun 2002 09:00:18 -0400
Received: from [62.70.58.70] ([62.70.58.70]:9962 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316621AbSFDNAN> convert rfc822-to-8bit;
	Tue, 4 Jun 2002 09:00:13 -0400
Message-Id: <200206041259.g54CxuP07700@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Dale Stephenson <dale.stephenson@quantum.com>,
        "'Kasper Dupont'" <kasperd@daimi.au.dk>
Subject: Re: SV: RAID-6 support in kernel?
Date: Tue, 4 Jun 2002 14:59:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Christian Vik <cvik@vanadis.no>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B02F17E@nasexs1.meridian-data.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course, for a 4 drive setup there's no reason to use RAID 6 at all (RAID
> 10 will withstand any two drive failure if you only use 4 drives), but
> that's the reasoning.  I think the best way to deal with the read-modify
> write problem for RAID 6 is to use a small chunk size and deal with NxN
> chunks as a unit.  But YMMV.

RAID10 will _not_ withstand any two-drive fail in a 4-drive scenario. If D1 
and D3 fail, you're fscked

D1 D2
D3 D4

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
