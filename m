Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289188AbSAORCO>; Tue, 15 Jan 2002 12:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289530AbSAORCF>; Tue, 15 Jan 2002 12:02:05 -0500
Received: from www.it-optics.com ([194.7.220.135]:65037 "HELO
	lme.it-optics.com") by vger.kernel.org with SMTP id <S289242AbSAORBv>;
	Tue, 15 Jan 2002 12:01:51 -0500
To: linux-kernel@vger.kernel.org
Subject: IDE-TAPE : having problem with atapi tape backup
Message-ID: <1011114244.3c4461045e289@mail.it-optics.com>
Date: Tue, 15 Jan 2002 18:04:04 +0100 (CET)
From: Michel APPLAINCOURT <michel.applaincourt@it-optics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.4
X-Originating-IP: 172.16.3.103
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know this question has been asked several times but I could not find an answer
:

I hav a Seagate Travan 20GB Atapi IDE tape, installed on a 2.2.16-22 Linux
(Redhat 6.2 version)
I had no problem accessing my backup as /dev/ht0, but since a little time (I
guess since the archive has got a certain minimum size), error messages showed
up on the console like :

ide-tape : ht0 : I/O error , pc = 10 , key = 0 , asc = 0 , ascq = 2 
couldn't write a filemark

I had some problems with files and wanted to get them back from archive, and I
cannot access to them, because I get error

[root@ulysse backup]# ./restore.sh
    Level-0 Backup Fri Jan 11 01:10:00 CET 2002
    Lecture de `Level-0 Backup Fri Jan 11 01:10:00 CET 2002'
    tar: Fin prématurée (EOF) rencontrée dans l'archive.
    tar: Erreur non récupérable: fin de l'exécution immédiate
    [root@ulysse backup]#

telling me i had a EOF too early in the file...

what can i do?
Is it ide-tape that has problem?

Thanks...
 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    Michel  APPLAINCOURT     | E-mail : michel.applaincourt@it-optics.com
      Managing Director      | Phone  : +32 65 321573
        IT-OPTICS s.a        | Fax    : +32 65 321574
 
           [The boy that you love is the man that you fear]
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
