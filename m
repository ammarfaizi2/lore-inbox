Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSCYBlI>; Sun, 24 Mar 2002 20:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310436AbSCYBk7>; Sun, 24 Mar 2002 20:40:59 -0500
Received: from kirsti.kvarteret.uib.no ([129.177.162.235]:34010 "EHLO
	ttt.kvarteret.org") by vger.kernel.org with ESMTP
	id <S293060AbSCYBkr>; Sun, 24 Mar 2002 20:40:47 -0500
Date: Mon, 25 Mar 2002 02:40:22 +0100
From: =?iso-8859-1?Q?Kjetil_Nyg=E5rd?= <kjetiln@kvarteret.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with booting from SX6000
Message-ID: <20020325024022.A6502@kvarteret.org>
In-Reply-To: <20020324210811.B29097@kvarteret.org> <E16pEo3-00079j-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
X-Scanner: exiscan *16pJTC-0001sL-00*bdZgm.2wytA* (Det Akademiske Kvarter, Bergen, Norway)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 08:41:35PM +0000, Alan Cox wrote:
> > I have problems with booting from a Promise SX6000. 
> > I installed rh7.2, but the kernel cannot mount the filesystem. I get error
> > 6 on mounting the file-system.  But in 'linux rescue' it manages to mount 
> > the filesystems fine.
> > 
> > What is wrong?
> 
> Firstly you must have recent firmware or the supertrak and SX6000 hang when
> the module is loaded twice (as occurs when kudzu probes). Secondly you
> should upgrade to the RH 2.4.9 errata kernel ASAP to avoid other weird hangs
> under load that the newer i2o driver works around.

I have now installed the latest rh-kernel. I have also tried the 2.4.18 kernel (There should be some fixes for Promise SX6000 there). And the firmware is the newest. But still the system hangs during booting. I get the following messages:


"""
Partition Check: 
i2o/hda: i2o/hda1 i2o/hda2 i2o/hda3 i2o/hda4 < i2o/hda5 i2o/hd6 >
Loading jbd module
Journaled Block Device loaded
Loading ext3 module
Mounting /proc filesystem
Creating root device
Mounting root filesystem
Mounting: error 19 ext3
pivotroot: pivot_root(/sysroot, /sysroot/initrd) failed: 2
Freeing unused kernel memory: 224k freed
Kernel panic: no init found.  Try pasing init= to kernel.
"""

There could be spelling-errors, but else it should be all right. I have not made any changes to the system. (pure rh-7.2 install)


Regards
	Kjetil Nygård

