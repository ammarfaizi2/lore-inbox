Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264402AbRFNCTk>; Wed, 13 Jun 2001 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264405AbRFNCTa>; Wed, 13 Jun 2001 22:19:30 -0400
Received: from f89.law12.hotmail.com ([64.4.19.89]:63756 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264402AbRFNCTN>;
	Wed, 13 Jun 2001 22:19:13 -0400
X-Originating-IP: [142.169.166.23]
From: "Seigneur Angmar" <seigneurangmar@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Lecteur CD-ROM
Date: Wed, 13 Jun 2001 22:19:03 -0400
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <F89qlOQq2vXqZAmN0oG000027c6@hotmail.com>
X-OriginalArrivalTime: 14 Jun 2001 02:19:04.0337 (UTC) FILETIME=[61F98810:01C0F478]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bonsoir,
    Je vous décrirai le problème du mieux que je peux.  Avant tout, je tiens 
à souligner que, sous les mêmes configurations, le problème ne s'est produit 
et reproduit que sur les kernels 2.4.X (kernels testés : 2.2.18, 2.2.19, 
2.4.0, 2.4.3, 2.4.5).

    J'ai en ma possession un CD-R (fait sous Windows 98) qui fonctionne sans 
reproches.  Absolument rien d'anormal ne se produit quand j'écris la ligne 
suivante : "mount /dev/cdrom".  Le problème survient quand j'essaye de 
copier un fichier sur le disc dur.  Le message suivant s'affiche :

hdb: command error: status=0x51 { DriveReady SeekComplete Error }
hdb: command error: error=0x54
end_request: I/O error, dev 03:40 (hdb), sector 14776
hdb: command error: status=0x51 { DriveReady SeekComplete Error }
hdb: command error: error=0x54
end_request: I/O error, dev 03:40 (hdb), sector 14780
cp: wumpscut - mortal highway.mp3: Input/output error
...

Je rappelle que ce problème n'est jamais arrivé sur aucuns des kernels 2.2.X 
que j'ai compilé.

N.B. : je possède un ATAPI CDROM: LTN242F

Merci beaucoup

Michel

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

