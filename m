Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281867AbRKWCwM>; Thu, 22 Nov 2001 21:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281869AbRKWCvx>; Thu, 22 Nov 2001 21:51:53 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46209 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281867AbRKWCvl>; Thu, 22 Nov 2001 21:51:41 -0500
Date: Thu, 22 Nov 2001 20:54:49 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [vojkan@global.net.mt: Re: RAW NTFS Partition]
Message-ID: <20011122205449.B5867@vger.timpanogas.org>
In-Reply-To: <5.1.0.14.2.20011123020459.0707dcd0@pop.cus.cam.ac.uk> <20011122200146.A2427@vger.timpanogas.org> <5.1.0.14.2.20011123020459.0707dcd0@pop.cus.cam.ac.uk> <20011122203850.A2557@vger.timpanogas.org> <5.1.0.14.2.20011123024021.06fe3ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20011123024021.06fe3ec0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Fri, Nov 23, 2001 at 02:46:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 02:46:47AM +0000, Anton Altaparmakov wrote:
> At 03:38 23/11/01, Jeff V. Merkey wrote:
> >I will downlaod and review where the code is at.  Write support is
> >going to be very tough at this point -- they have changed some of
> >the on-disk strucutures again for the journal and several meta
> >files.
> 
> I am not bothered about the journal until there is fully working support 
> for NTFS on Linux. After that I will start thinking about journalling.
> 
> I haven't noticed any changes between Win2k and WinXP except for the 
> extension of the MFT_RECORD structure (see 
> ntfs-driver-tng:linux/fs/ntfs/layout.h) to contain the mft record number 
> (great data recovery info). Although it is confusing that they are only 
> using 32 bits there as otherwise the mft record numbers are 48-bit. Not 
> quite sure what to make of that...


This is because you are not messing around with the journal at present.  


> 
> >However, with the DOJ settlement, they will be required to share this 
> >information, so our job could get easier.  I will approach some folks and 
> >see where they are at.  Hopefully, it won't go down the way it did last time.
> 
>  From what I have read I doubt the DOJ settlement will be any benefit to 
> NTFS development on Linux but it's certainly worth a try.


I fired off an email to them.  The worst that can happen is they will 
say "Hell no."

Jeff

> 
> Best regards,
> 
> Anton
> 
> >On Fri, Nov 23, 2001 at 02:16:04AM +0000, Anton Altaparmakov wrote:
> > > At 03:01 23/11/01, Jeff V. Merkey wrote:
> > > >Can you help this person?
> > >
> > > I will reply to him off line. Sounds to me he is in desperate need of a
> > > data recovery company not of diskedit... Using diskedit on his part can
> > > damage the volume even more and if it is a whole year worth of work paying
> > > a few thousand dollars to get the data recovered is peanuts... If he
> > > insists then I will help him of course but I think it's a bad idea.
> > >
> > > >My 18 months has now expired.  I can help on NTFS now if you need some 
> > help.
> > >
> > > That's cool to know. I am developing a new NTFS driver - NTFS TNG. It is
> > > read-only for now and it is almost complete with regards to basic read
> > > support. I.e. it works NOW. - The only thing that is missing is attribute
> > > list attribute support but I am working on it as we speak. (-;
> > >
> > > If you or anyone else of course is interested in participating in
> > > development, have a look. Code is in module ntfs-driver-tng in Sourceforge
> > > linux-ntfs CVS. URL with cvs access details:
> > >
> > >          http://sourceforge.net/cvs/?group_id=13956
> > >
> > > Note that the module requires some small changes to the core kernel and 
> > the
> > > appropriate patch is maintained in ntfs-driver-tng/patches directory.
> > > Currently kernel 2.4.15-pre4 is supported but patch might apply to later
> > > -pres as well.
> > >
> > > After applying the patch and installing the new NTFS module sources NTFS
> > > TNG is completely separate from the kernel tree (all code including 
> > headers
> > > is in fs/ntfs and nowhere else and the include/linux/fs.h dependencies are
> > > gone).
> > >
> > > One word of warning: NTFS TNG requires gcc-2.96 or later to compile. It
> > > will NOT compile with earlier versions of gcc! You will just get a million
> > > or so errors if you try any earlier gcc compiler...
> > >
> > > Best regards,
> > >
> > > Anton
> > >
> > >
> > > --
> > >    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> > > --
> > > Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> > > Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
> > > ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
>    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
