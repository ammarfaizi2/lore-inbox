Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273755AbRIQXeg>; Mon, 17 Sep 2001 19:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273757AbRIQXe1>; Mon, 17 Sep 2001 19:34:27 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47092
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273755AbRIQXeR>; Mon, 17 Sep 2001 19:34:17 -0400
Date: Mon, 17 Sep 2001 16:34:34 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
Message-ID: <20010917163434.B28180@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15j68m-0007wc-00@the-village.bc.nu> <3BA6791A.616636CE@MissionCriticalLinux.com> <9o5voq$21d$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9o5voq$21d$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 04:08:10PM -0700, H. Peter Anvin wrote:
> Followup to:  <3BA6791A.616636CE@MissionCriticalLinux.com>
> By author:    Bruce Blinn <blinn@MissionCriticalLinux.com>
> In newsgroup: linux.dev.kernel
> > 
> > I do not think the disk is missing data or that there are any bad
> > blocks.  The reason I say this is because I can access every file on the
> > disk when the CD is mounted as an iso9660 file system on a 2.2.19
> > kernel.  I compared the files with the originals and they are identical.
> > 
> > The only reason I found out dd would not copy the disk is because Masoud
> > asked for an image.
> > I tried using dd to copy a much larger CD (150 Mb) and it fails at the
> > same place and the resulting file is the same size (737280 bytes).  So
> > it fails long before the end of the data.
> > 
> > By the way, dd works fine when copying other CDs that were not created
> > under Windows.
> > 
> 
> This almost seems to imply they're recording the data noncontiguously,
> which would be totally bizarre but not totally impossible.
> 

I've seen commercial CD do this.  Maybe that dd trick to skip empty parts
and pad with zeros would work...
