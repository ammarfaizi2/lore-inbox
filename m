Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283740AbRLEEk5>; Tue, 4 Dec 2001 23:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283748AbRLEEkr>; Tue, 4 Dec 2001 23:40:47 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47860
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283740AbRLEEk0>; Tue, 4 Dec 2001 23:40:26 -0500
Date: Tue, 4 Dec 2001 20:40:19 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rasmus B?g Hansen <moffe@amagerkollegiet.dk>
Cc: Erik Tews <erik.tews@gmx.net>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-kernel@vger.kernel.org
Subject: Re: tuning ext2 or ReiserFS to avoid fragmentation with large files?
Message-ID: <20011204204019.F25292@mikef-linux.matchmail.com>
Mail-Followup-To: Rasmus B?g Hansen <moffe@amagerkollegiet.dk>,
	Erik Tews <erik.tews@gmx.net>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011204142047.N11967@no-maam.dyndns.org> <Pine.LNX.4.33.0112050315450.2930-100000@grignard.amagerkollegiet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112050315450.2930-100000@grignard.amagerkollegiet.dk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 03:17:17AM +0100, Rasmus B?g Hansen wrote:
> On Tue, 4 Dec 2001, Erik Tews wrote:
> 
> > If I remember right xfs has got a online-defragmentation utility. So
> > have a look at xfs.
> > 
> > I think xfs works different from reiserfs and ext2 when writing files to
> > disk which helps avoiding fragmentation. This feature is called
> > allocation groups.
> 
> I *might* be wrong, but isn't the allocation-group thing exactly what 
> ext2/ext3 does?
>

Basically, yes.  They both have the name "group" in some of their feature
lists.  What really matters is *what* they encompass, and *how* they're used.

Can someone in the know comment about the similarity of the ext[23] and xfs
groups?
