Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282163AbRK1PaH>; Wed, 28 Nov 2001 10:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282156AbRK1P3r>; Wed, 28 Nov 2001 10:29:47 -0500
Received: from firewall.synchrotron.fr ([193.49.43.1]:29374 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S281560AbRK1P3k>;
	Wed, 28 Nov 2001 10:29:40 -0500
Date: Wed, 28 Nov 2001 16:29:06 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Ieee1394
Message-ID: <20011128162906.A29500@pcmaftoul.esrf.fr>
In-Reply-To: <20011128103256.A28083@pcmaftoul.esrf.fr> <20011128090928.I23907@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20011128090928.I23907@visi.net>; from bcollins@debian.org on Wed, Nov 28, 2001 at 09:09:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 09:09:28AM -0500, Ben Collins wrote:
> On Wed, Nov 28, 2001 at 10:32:56AM +0100, Samuel Maftoul wrote:
> > Hello everyone,
> >         Still me with my ieee1394 problems :)
> > 
> > Workaround: My goal is to make ieee1394 HardDisk  work in a production 
> > environment:
> > 	User come on a machine, plug his disk, store his (experience 
> > 	results) datas on it, unplugs it and go away with it in his home
> > 	institute where he processes his datas.
> 
> I don't see any mention of the kernel version you are using, nor about
> the specific ohci chipset, or the hardware (ppc, i386?).
> 
> Give me some details. I don't see this issue right now, but I'm using
> linux1394 CVS.
i386, AFW-4300, 2.4.16, ieee1394 from kernel (not CVS , but soon CVS :)
)
Most problems resolved.
Now I'm working on a script to automount and autoumount the HD.
This is so fucking hard 'cause we are not aware of what user wants to
use the disk (for mount -o user to let the user accessing his datas in
rw mode). Another problem is the umount: if the directory s busy, my
script isn't able to du "cd .." for the user ...
so crazy
        Sam
> 
> 
> Ben
> 
> -- 
>  .----------=======-=-======-=========-----------=====------------=-=-----.
> /                   Ben Collins    --    Debian GNU/Linux                  \
> `  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
>  `---=========------=======-------------=-=-----=-===-======-------=--=---'
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
