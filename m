Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRJTQ2D>; Sat, 20 Oct 2001 12:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273648AbRJTQ1n>; Sat, 20 Oct 2001 12:27:43 -0400
Received: from [210.212.161.28] ([210.212.161.28]:2276 "EHLO
	prodserver1.goatelecom.com") by vger.kernel.org with ESMTP
	id <S273622AbRJTQ1d>; Sat, 20 Oct 2001 12:27:33 -0400
Date: Sat, 20 Oct 2001 21:57:54 +0000
From: Rajesh Fowkar <rajesh@symonds.net>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.12 & vfat partition
Message-ID: <20011020215754.A8685@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: Rajesh Consultancy <http://www.symonds.net/~rajesh/>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hopefully this is the correct list for asking this type of question. If not
than please direct me to the proper list.

With kernel 2.4.9 whenever I mounted a vfat partition the executable bits
of the files were not set, as a result in rox-filer I was getting the
proper association to the application. 

But since kernel 2.4.10 onwards the
executable bits of all the files in vfat partions are set. Due to this in
rox-filer I get all the files as executables and I can not open any file in
proper association. Any way to unset the executable bits on vfat partition
mounting ?

I have got the following in my /etc/fstab :

/dev/hda6       /mnt/funstuff   vfat    defaults,errors=remount-ro,users 0       0

At present I am on kernel 2.4.12 with ext3 patch applied from :

ftp://perlsupport.com/pub/linux/kernel/ext3-0.9.12-2.4.12.patch.gz

Thanks in advance.

Warm Regards

Peace

--
Rajesh 
http://www.symonds.net/~rajesh/    *****  Powered By: Debian GNU/Linux
					              Kernel 2.4.12(ext3)
You have no real enemies.
