Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRA3NM3>; Tue, 30 Jan 2001 08:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbRA3NMK>; Tue, 30 Jan 2001 08:12:10 -0500
Received: from [213.4.194.5] ([213.4.194.5]:41230 "EHLO protoss")
	by vger.kernel.org with ESMTP id <S130036AbRA3NMG>;
	Tue, 30 Jan 2001 08:12:06 -0500
From: Javier Miguel Rodríguez (GUFO) 
	<javier.miguel@futurainteractiva.com>
Organization: Futura Interactiva
To: linux-kernel@vger.kernel.org
Date: Tue, 30 Jan 2001 14:07:01 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
MIME-Version: 1.0
Message-Id: <01013014063301.15042@Petete>
Content-Transfer-Encoding: 8bit
Subject: 2.4.0+ipchains+sparc 450= CRASH!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


	   I have read and applied /usr/src/linux-2.4.0/Documentation/Changes
in this machine, but...it does not work

<-------------------------------------------------------->
<-------------------------------------------------------->

        Sun UltraSparc 450, 1 hd scsi, 512 mb ram, kernel 2.4.0,
 debian woody, kernel 2.4.0
 
        I use kernel 2.4.0 + ipchains compatibilty. I use ipchains 1.3.9
 
 This code:
 
 ipchains -A input -p tcp --dport 80 -s 192.168.0.35 -j REDIRECT 81
 
        CRASHES the machine! No response to pings, no network activity, no 
console prompt response, NOTHING. And /var/log/messages does not say nothing 
about the problem...
 
        But if I do the same sentence it with 2.2.18 or with iptables in 
2.4.0, works ok :-(

<-------------------------------------------------------->
<-------------------------------------------------------->

	If you need more info, please reply this e-mail

- -- 
Javier Miguel Rodríguez.	(GUFO)                                              
Administrador de Sistemas
Futura Interactiva				Powered by Linux 2.4.0
www.futurainteractiva.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjp2yokACgkQnLdfr0FC/yIWtgCgp4A7PJ7olIfy6n48blg5eq5D
fuQAnjd3Wz7i63QsOvEjQaVu/3xYi/h9
=qZPy
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
