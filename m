Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQKNUN5>; Tue, 14 Nov 2000 15:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130511AbQKNUNd>; Tue, 14 Nov 2000 15:13:33 -0500
Received: from unimur.um.es ([155.54.1.1]:31726 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S129551AbQKNUN0>;
	Tue, 14 Nov 2000 15:13:26 -0500
Message-ID: <3A1198FD.FB50B05E@ditec.um.es>
Date: Tue, 14 Nov 2000 20:56:45 +0100
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.75 [es] (X11; U; Linux 2.2.18pre17 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Addressing logically the buffer cache
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!.

Is there any patch or project to address logically the buffer cache?.
Now, you use three parameters to find a buffer in cache: device, block
number, and block size. But, what about if I want to find a buffer using
a super block, an inode number, and a block number within the file
specified by the inode number.

This mechanism would be very useful for a log-structured file system,
for example.

Thanks in advance
-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968364633    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
