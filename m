Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291258AbSAaUDh>; Thu, 31 Jan 2002 15:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291259AbSAaUDb>; Thu, 31 Jan 2002 15:03:31 -0500
Received: from 200-171-140-137.dsl.telesp.net.br ([200.171.140.137]:19464 "HELO
	josephine.e-mail4you.com.br") by vger.kernel.org with SMTP
	id <S291258AbSAaUDV>; Thu, 31 Jan 2002 15:03:21 -0500
Date: Thu, 31 Jan 2002 18:04:15 -0200
From: michelpereira@uol.com.br (Michel Angelo da Silva Pereira)
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18pre7-ac2
Message-ID: <20020131180415.A9820@josephine.e-mail4you.com.br>
In-Reply-To: <200201311914.g0VJEkG08832@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <200201311914.g0VJEkG08832@devserv.devel.redhat.com>; from alan@redhat.com on Thu, Jan 31, 2002 at 02:14:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	And that problem with the I2O subsystem that hangs Intel ServerRAID SRVU-31 card on detection process?

Bye

On Thu, Jan 31, 2002 at 02:14:46PM -0500, Alan Cox wrote:
> This is just a standing still release. Most of the work was actually done
> by Arjan van de Ven.
> 
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.18pre7-ac2
> +	i810 audio driver update			(Doug Ledford)
> o	Early ioremap for x86 specific code		(Mikael Pettersson)
> 	| This is needed to do things like apic/dmi detect early enough
> o	Pentium IV APIC/NMI watchdog			(Mikael Pettersson)
> o	Add C1MRX support to sonypi driver		(Junichi Morita)
> o	Fix "make rpm" with two '-' in extraversion	(Gerald Britton)
> o	Fix aacraid hang/irq storm on i960 boards	(Chris Pascoe)
> o	Fix isdn audio compiler behaviour dependancy	(Urs Thuermann)
> o	YAM driver fixes				(Jean-Paul Roubelat)
> o	ROSE protocol stack update/fixes		(Jean-Paul Roubelat)
> o	Fix UFS/CDROM oops				(Zwane Mwaikambo)
> o	Fix nm256 hang on Dell Latitude			(origin unknown)
> 	| Please test this tree with other NM256 based boxes and check
> 	| those still work...
> o	Merge PnPBIOS patch		(Thomas Hood, David Hinds, Tom Lees,
> 					 Christian Schmidt, ..)
> o	Merge new sis frame buffer drivers		(Thomas Winischhofer)
> o	cs46xx oops fix					(Mike Gorse)
> o	Fix a second cs46xx bug related to this		(me)
> o	Fix acpitable oopses on boot and other problems	(James Cleverdon)
> o	Fix io port type on the hpt366 driver		(Pete Popov)
> o	Updated matrox drivers				(Petr Vandrovec)
> +	IPchains fixes needed for 2.4.18pre7
> o	IDE config text updates for the IDE patches	(Anton Altaparmakov)
> o	Merge the first bits of ZV support		(Marcus Metzler)
> o	Add initial ZV support to yenta socket driver	(me)
> 	for TI cards
> o	Fix pirq routing on the CS5530 			(me)
> 	| Finally the palmax pcmcia/cardbus works properly
> 
> Linux 2.4.18pre7-ac1
> o	Merge with 2.4.18pre7				(Arjan van de Ven)
> 	| + some quota fixups redone by me
> 	| several 18pre7 netfilter bugs left unfixed for now
> o	Rmap-12a					(Rik van Riel and co)
> 
> Linux 2.4.18pre3-ac2
> 
> o	Re-merge the IDE patches			(Andre Hedrick and co)
> *	Fix check/request region in ali_ircc and lowcomx(Steven Walter)
> 	com90xx, sealevel, sb1000
> *	Remove unused message from 6pack driver		(Adrian Bunk)
> *	Fix unused variable warning in i60scsi		(Adrian Bunk)
> *	Fix off by one floppy oops			(Keith Owens)
> o	Fix i2o_config use of undefined C		(Andreas Dilger)
> *	Fix fdomain scsi oopses				(Per Larsson)
> *	Fix sf16fmi hang on boot			(me)
> o	Add bridge resources to the resource tree	(Ivan Kokshaysky)
> *	Fix iphase ATM oops on close in on case	   (Till Immanuel Patzschke)
> +	Enable OOSTORE on winchip processors		(Dave Jones, me)
> 	| Worth about 10-20% performance 
> *	Code Page 1250 support				(Petr Titera)
> *	Fix sdla and hpfs doc typos			(Sven Vermeulen)
> o	Document /proc/stat				(Sven Heinicke)
> *	Update cs4281 drivers				(Tom Woller)
> 	| Fixes xmms stutter, remove wrapper code
> 	| handle tosh boxes, allow record device change
> 	| trigger wakeups on ioctl triggered changes
> +/o	Fix locking of file struct stuff found by ibm	(Dipankar Sarma)
> 	audit
> o	Use spin_lock_init in serial.c			(Dave Miller)
> *	Fix AF_UNIX shutdown bug			(Dave Miller)
> 
> Linux 2.4.18pre3-ac1
> 
> o	32bit uid quota
> o	rmap-11b VM					(Rik van Riel,
> 							 William Irwin etc)
> +	Make scsi printer visible			(Stefan Wieseckel)
> *	Report Hercules Fortissimo card			(Minya Sorakinu)
> *	Fix O_NDELAY close mishandling on the following	(me)
> 	sound cards: cmpci, cs46xx, es1370, es1371,
> 	esssolo1, sonicvibes
> *	tdfx pixclock handling fix			(Jurriaan)
> o	Fix mishandling of file system size limiting	(Andrea Arcangeli)
> +	generic_serial cleanups				(Rasmus Andersen)
> o	serial.c locking fixes for SMP - move from cli	(Kees)
> 	too
> *	Truncate fixes from old -ac tree		(Andrew Morton)
> +	Hopefully fix the i2o oops			(me)
> 	| Not the right fix but it'll do till I rewrite this
> *	Fix non blocking tty blocking bug		(Peter Benie)
> o	IRQ routing workaround for problem HP laptops	(Cory Bell)
> *	Fix the rcpci driver				(Pete Popov)
> *	Fix documentation of aedsp location		(Adrian Bunk)
> *	Fix the worst of the APM ate my cpu problems	(Andreas Steinmetz)
> *	Correct icmp documentation			(Pierre Lombard)
> *	Multiple mxser crash on boot fix	(Stephan von Krawczynski)
> o	ldm header fix					(Anton Altaparmakov)
> *	Fix unchecked kmalloc in i2c_proc	(Ragnar Hojland Espinosa)
> *	Fix unchecked kmalloc in airo_cs	(Ragnar Hojland Espinosa)
> *	Fix unchecked kmalloc in btaudio	(Ragnar Hojland Espinosa)
> *	Fix unchecked kmalloc in qnx4/inode.c	(Ragnar Hojland Espinosa)
> *	Disable DRM4.1 GMX2000 driver (4.0 required)	(me)
> *	Fix sb16 lower speed limit bug			(Jori Liesenborgs)
> o	Fix compilation of orinoco driver		(Ben Herrenschmidt)
> +	ISAPnP init fix					(Chris Rankin)
> o	Export release_console_sem			(Andrew Morton)
> *	Output nat crash fix				(Rusty Russell)
> *	Fix PLIP					(Niels Jensen)
> o	Natsemi driver hang fix				(Manfred Spraul)
> *	Add mono/stereo reporting to gemtek pci radio	(Jonathan Hudson)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
=================================================
Borges & Rinolfi Soluções em Redes Corporativas
Security Officer
Profissional Certificado Conectiva Linux
www.techs.com.br/kidmumu - UIN 4553082 - LC 83522
=================================================

