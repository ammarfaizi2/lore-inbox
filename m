Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKQIDj>; Fri, 17 Nov 2000 03:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKQIDT>; Fri, 17 Nov 2000 03:03:19 -0500
Received: from post.polcard.com.pl ([195.116.107.242]:49928 "HELO
	polcard.com.pl") by vger.kernel.org with SMTP id <S129111AbQKQIDP> convert rfc822-to-8bit;
	Fri, 17 Nov 2000 03:03:15 -0500
Date: Fri, 17 Nov 2000 08:06:10 +0100
From: Jaros³aw Bekas <jaroslaw.bekas@polcard.com.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11-pre6 dev.c compile error
Message-ID: <20001117080610.A6088@jaro.polcard.com.pl>
Reply-To: Jaros³aw Bekas <jaroslaw.bekas@polcard.com.pl>
Mime-Version: 1.0
User-Agent: Mutt/1.2.5i
Organization: Polcard
X-MIMETrack: Itemize by SMTP Server on lotusik/Polcard(Release 5.0.4a |July 24, 2000) at
 2000-11-17 08:05:57,
	Serialize by Router on lotusik/Polcard(Release 5.0.4a |July 24, 2000) at
 2000-11-17 08:32:52
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello 

I try to compile 2.4.0-test11-pre6, and recive error: 

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o dev.o
dev.c
dev.c: In function `run_sbin_hotplug':
dev.c:2736: `hotplug_path' undeclared (first use in this function)
dev.c:2736: (Each undeclared identifier is reported only once
dev.c:2736: for each function it appears in.)

linux/kmod.h is included in dev.c 

Regards

-- 

Jaros³aw Bekas
<jaroslaw.bekas@polcard.com.pl>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
