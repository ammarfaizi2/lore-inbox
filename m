Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSFUPiO>; Fri, 21 Jun 2002 11:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSFUPiN>; Fri, 21 Jun 2002 11:38:13 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:29513 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S316663AbSFUPiM>; Fri, 21 Jun 2002 11:38:12 -0400
Date: Fri, 21 Jun 2002 18:38:01 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
       Andreas Dilger <adilger@clusterfs.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020621153801.GK1465@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Andreas Dilger <adilger@clusterfs.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <20020620103429.A2464@redhat.com> <20020620101812.GL22427@clusterfs.com> <E17L2G0-00019Q-00@starship> <20020621145451.GA1548@niksula.cs.hut.fi> <20020621160833.D2805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621160833.D2805@redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 04:08:33PM +0100, you [Stephen C. Tweedie] wrote:
> 
> That was Ted's microoptimisation to start directory lookups at the
> point where we last looked in the directory. 

That exactly. (Micro maybe in size, but I gather the sped up lookups quite a
bit in some cases?)

> It's in ext3 already these days,

So I thought, but not in ext2?

> and it would definitely help for the mass-delete case.

Yep. Anyway, nice to see the large dir case is being addressed.


-- v --

v@iki.fi
