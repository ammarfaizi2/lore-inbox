Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSDAC6A>; Sun, 31 Mar 2002 21:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293089AbSDAC5u>; Sun, 31 Mar 2002 21:57:50 -0500
Received: from th09.opsion.fr ([195.219.20.19]:28938 "HELO th09.opsion.fr")
	by vger.kernel.org with SMTP id <S292870AbSDAC5i>;
	Sun, 31 Mar 2002 21:57:38 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: apolon <apolon_lovlilis@ifrance.com>
To: linux-kernel@vger.kernel.org
Subject: bug with floppy drive
Date: Mon, 1 Apr 2002 05:00:19 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-id: <200204010257.10e3@th09.opsion.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a bug using my floppy drive under linux

when i try to fdformat a floppy, i get this error:

	fdformat /dev/fd0H1440
	Double-faces, 80 pistes, 18 sec/piste. Capacité totale 1440Ko.
	Formatage en cours ... terminé
	Verification en cours ... Lecture : : Erreur d'entree/sortie
	Probleme lors de la lecture du cylindre 0, 18432 attendu, -1 lu

when i try to mke2fsck /dev/fd0H1440, it hangs and my floppy driver seeks 
infinitely

I've try with a lot of floppies and with another floppy drive and I get the 
same error
my floppy drive works fine under window$

I'm using the kernel 2.4.18 from kernel.org, with a redhat 7.2

I own a Abit kg7, a amd duron 1000 processor 

I'm at your disposition if you need some help, or renseignements

Fabien
 
______________________________________________________________________________
ifrance.com, l'email gratuit le plus complet de l'Internet !
vos emails depuis un navigateur, en POP3, sur Minitel, sur le WAP...
http://www.ifrance.com/_reloc/email.emailif


