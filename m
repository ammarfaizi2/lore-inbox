Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280357AbRJaRxz>; Wed, 31 Oct 2001 12:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280366AbRJaRwZ>; Wed, 31 Oct 2001 12:52:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280364AbRJaRwV>; Wed, 31 Oct 2001 12:52:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cdrecord from ext3
Date: 31 Oct 2001 09:52:40 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9rpdp8$601$1@cesium.transmeta.com>
In-Reply-To: <20011031001846.A1840@werewolf.able.es> <3BDF576F.3A797933@zip.com.au> <20011031155934.A18608@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011031155934.A18608@werewolf.able.es>
By author:    "J . A . Magallon" <jamagallon@able.es>
In newsgroup: linux.dev.kernel
> 
> Did you noticed that the ext3 was at 20MHz, and ext2 was at 40MHz ? I
> will reformat the 20MHz drive and make 2 slices, one ext2 and one ext3
> to be sure not to compare apples and oranges...
> 

Doesn't work.  Low block numbers (outer edge of the disk) is
invariably faster than high block numbers (inner edge of the disk) on
all drives that are even close to recent.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
