Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSHOT57>; Thu, 15 Aug 2002 15:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSHOT57>; Thu, 15 Aug 2002 15:57:59 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:18682 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317366AbSHOT57>; Thu, 15 Aug 2002 15:57:59 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 15 Aug 2002 13:59:33 -0600
To: Tom Rini <trini@kernel.crashing.org>
Cc: henrique <henrique@cyclades.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
Message-ID: <20020815195933.GW9642@clusterfs.com>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	henrique <henrique@cyclades.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200208151514.51462.henrique@cyclades.com> <20020815182556.GV9642@clusterfs.com> <20020815190336.GN22974@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020815190336.GN22974@opus.bloom.county>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2002  12:03 -0700, Tom Rini wrote:
> On Thu, Aug 15, 2002 at 12:25:56PM -0600, Andreas Dilger wrote:
> > Maybe the PPC keyboard/mouse drivers do not add randomness?
> 
> Well, how is this set for the i386 ones?  I grepped around and I didn't
> really see anything, so I'm sort-of confused.

I think it is something like "add_mouse_entropy" and "add_keyboard_entropy"
or similar.  If you look at the random.c sources you can find the actual
function names and work backwards from there.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

