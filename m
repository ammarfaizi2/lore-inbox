Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275568AbRJQKii>; Wed, 17 Oct 2001 06:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275671AbRJQKi3>; Wed, 17 Oct 2001 06:38:29 -0400
Received: from [194.51.220.145] ([194.51.220.145]:52989 "EHLO
	mafalda.tuxfinder.com") by vger.kernel.org with ESMTP
	id <S275568AbRJQKiS>; Wed, 17 Oct 2001 06:38:18 -0400
Date: Wed, 17 Oct 2001 12:38:41 +0200
From: Stephane Jourdois <stephane@tuxfinder.org>
To: Barry Wu <wqb123@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can linux kernel boot from parallel port device?
Message-ID: <20011017123841.A19305@mafalda.duke-interactive.com>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <20011017002040.48151.qmail@web13907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011017002040.48151.qmail@web13907.mail.yahoo.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.12-ac2-evintage
X-Send-From: mafalda.tuxfinder.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 05:20:40PM -0700, Barry Wu wrote:
> Hi, all, I want to boot linux  kernel  directly from mainboard rom or flash,
> but the rom on mainboard is small  and  it  contains BIOS in it. Therefore I
> want to boot kernel from parallel port.  I  can put linux kernel on parallel
> storage. Is it possible to boot linux kernel  from parallel port? If so, how
> to modify the kernel? If someone knows, please help me.

IMHO if you don't have an option in your BIOS to boot on a parallel
device, that won't be possible. The problem is not the kernel or any OS
itself, but your BIOS that won't be able to jump to runnable code.
Usually, your BIOS looks for a MBR on the selected device. If that
device isn't recognised by the BIOS itself, of course it won't find any
Operating System.

Perhaps there is another solution, but much difficult :
If grub or any loader is able to recognize your parallel device, it will
be able to boot on it. But that requires a hard disk or at least a
floppy drive, and a modified version of grub or any loader.

Bye,

--
Stephane Jourdois - Ingénieur développement  /"\
  6, av. de la Belle Image                   \ /  ASCII RIBBON CAMPAIGN
  94440 Marolles en Brie   - FRANCE           X     AGAINST HTML MAIL
     +33 6 8643 3085                         / \
