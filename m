Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbRBGQdr>; Wed, 7 Feb 2001 11:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129479AbRBGQdg>; Wed, 7 Feb 2001 11:33:36 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:46861 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S129477AbRBGQd1>; Wed, 7 Feb 2001 11:33:27 -0500
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF68391C@mailsrv.linkvest.ch>
From: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
To: "'acl-devel@bestbits.at'" <acl-devel@bestbits.at>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Lock in with 2.4.1 and NFS
Date: Wed, 7 Feb 2001 17:33:08 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I have a strange problem on one of our server.
I have 2.4.1 patched with ACLs 0.7.5 (from acl.bestbits.at) and some RAID +
LVM volumes.
At regular interval, NFS stops working (nfsd stops) and a stop/start of the
NFS service doesn't work. 
The NFS service stop blocks in "exportfs -auv" when trying to unmount a
client working apparently well. One time
it was a solaris 2.6 client, another time it was a linux 2.4 machine.
Any help appreciated.
Thanks
-jec

PS: I'm not in the kernel list. Please CC


_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
http://www.linkvest.com  E-mail: jean-eric.cuendet@linkvest.com
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
