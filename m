Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRBWKrq>; Fri, 23 Feb 2001 05:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbRBWKrg>; Fri, 23 Feb 2001 05:47:36 -0500
Received: from WebDev.iNES.RO ([193.230.220.6]:12748 "HELO webdev.ines.ro")
	by vger.kernel.org with SMTP id <S129460AbRBWKrW>;
	Fri, 23 Feb 2001 05:47:22 -0500
Date: Fri, 23 Feb 2001 12:46:48 +0200 (EET)
From: Umbra <shadow@webdev.ines.ro>
cc: lk <linux-kernel@vger.kernel.org>
Subject: Re: Buglet: Mount iso-9660 always have exec bit set (755)
In-Reply-To: <3A963909.7A72B28@interplus.ro>
Message-ID: <Pine.LNX.4.30.0102231246100.27033-100000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Mircea Ciocan wrote:

>
> 	For a while I'm annoyed by a buglet:
>
> When trying to mount an ordinary CD like (as root):
>
> mount /dev/cdrom /mnt/cdrom -o ro,noexec

Try mount /dev/cdrom /mnt/cdrom -o ro,noexec,mode=0444

>
> it works, but all files have the execute attribute set for all users,
> and that is annoying in
>
> MidnightCommander and other filemanagers that try execute the file as a
> program instead of opening it based on file asociation set.
>
> Mount version is: mount-2.10o
> kernel2.4.1ac10 but see the same behaviour on all 2.4.x kernels.
>
> 	Is that something that I miss or is a small buglet in mounting isofs
> ???
>
> 		Thank you
>
> 		Mircea C.
>
> P.S: That problem didn't arise when using 2.2.x.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

