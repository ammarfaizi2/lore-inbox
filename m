Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSFUPJM>; Fri, 21 Jun 2002 11:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSFUPJL>; Fri, 21 Jun 2002 11:09:11 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:33155 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316636AbSFUPJK>; Fri, 21 Jun 2002 11:09:10 -0400
Date: Fri, 21 Jun 2002 16:08:33 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
       Daniel Phillips <phillips@bonn-fries.net>,
       Andreas Dilger <adilger@clusterfs.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020621160833.D2805@redhat.com>
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <20020620103429.A2464@redhat.com> <20020620101812.GL22427@clusterfs.com> <E17L2G0-00019Q-00@starship> <20020621145451.GA1548@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020621145451.GA1548@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Fri, Jun 21, 2002 at 05:54:51PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 21, 2002 at 05:54:51PM +0300, Ville Herva wrote:
 
> Daniels patch seems great. I also recall someone (Ted T'so? Stephen Tweedie?)
> had another dir access speed-up patch for ext3... Is that applicable to ext2
> or was it already merged?

That was Ted's microoptimisation to start directory lookups at the
point where we last looked in the directory.  It's in ext3 already
these days, and it would definitely help for the mass-delete case.

Cheers,
 Stephen
