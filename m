Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131036AbRBDAOx>; Sat, 3 Feb 2001 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131226AbRBDAOn>; Sat, 3 Feb 2001 19:14:43 -0500
Received: from hall.mail.mindspring.net ([207.69.200.60]:49970 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131036AbRBDAOh>; Sat, 3 Feb 2001 19:14:37 -0500
From: lists@frednet.dyndns.org
Date: Sat, 3 Feb 2001 18:14:33 -0600
To: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux-NTFS project, first public release
Message-ID: <20010203181433.A2882@frednet.dyndns.org>
In-Reply-To: <5.0.2.1.2.20010203184941.00a95ae0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010203184941.00a95ae0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Sat, Feb 03, 2001 at 07:08:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank goodness, it's about time.  :-)

On Sat, Feb 03, 2001 at 07:08:44PM +0000, Anton Altaparmakov wrote:
> This is to announce the first public release of the Linux-NTFS project 
> hosted on sourceforge. The project page, where you can download the source 
> code tar ball or rpm as well as precompiled RPMs for RedHat Linux 7.0 (i386 
> architecture only), is:
>          http://sourceforge.net/projects/linux-ntfs/
> You can also use the CVS server if you prefer...
> Note, that you need the kernel headers installed to compile linux-ntfs 
> source (probably you will need 2.4.x kernel headers and not 2.2.x ones but 
> I haven't actually checked whether it works with 2.2.x or not).
> 
> The first release contains the all new and wonderful ntfsfix utility, which 
> repairs some of the damage that the current Linux NTFS driver does when 
> writing to an NTFS partition.
> 
> If you are doing any writing to NTFS partitions using the Linux NTFS driver 
> this is an absolute *MUST* at the present time. It won't solve all 
> problems, but it goes quite some way to prevent data corruption.
> 
> Run it after dismounting your NTFS partition in Linux but before rebooting 
> into Windows NT/2000.
> 
> Note, after running the utility, when Windows boots up it will run an 
> automatic chkdsk on the partition which will finish fixing the damage done 
> by the Linux NTFS driver without corrupting the written data or any other 
> data (as long as the Linux NTFS driver hasn't corrupted something beyond 
> repair, obviously).
> 
> For amusement value, the first release also includes the ntfsdump_logfile 
> utility which when used on an NTFS partition will display information about 
> the journal ($LogFile) of that partition.
> 
> Finally both these utilities make use of the also included NTFS library 
> which offer NTFS access to open source programs. It is currently under 
> heavy development and the API is not going to remain as it is so don't use 
> it yet for your own programs.
> 
> For everyone interested in NTFS on-disk structures and functionality, you 
> will find the doc directory and especially the include directory to be of 
> great interest as the later includes header files with all known to me NTFS 
> structures. I still haven't gone through all the NTFS information that is 
> available so they are considered work in progress but are fairly complete I 
> thing. Most people will probably find that the $LogFile structures have 
> never been published before anywhere and now we have the restart area 
> structure definitions.
> 
> Any problems compiling/running the utilities, just give me a shout, or even 
> better submit bug reports on the project page!
> 
> Enjoy!
> 
> Anton
> 
> 
> -- 
> "Intelligence is the ability to avoid doing work, yet get the work done". - 
> Linus Torvalds
> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
