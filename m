Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbRBVEDi>; Wed, 21 Feb 2001 23:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbRBVEDT>; Wed, 21 Feb 2001 23:03:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8968 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129419AbRBVEDP>; Wed, 21 Feb 2001 23:03:15 -0500
Message-ID: <3A948F7B.E40C81D5@transmeta.com>
Date: Wed, 21 Feb 2001 20:03:07 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <200102220203.f1M237Z20870@webber.adilger.net> <3A947C54.E4750E74@transmeta.com> <3A948ACB.7B55BEAE@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> There will be a lot fewer metadata index
> blocks in your directory file, for one thing.
> 

Oh yes, another thing: a B-tree directory structure does not need
metadata index blocks.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
