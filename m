Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277361AbRJEL6M>; Fri, 5 Oct 2001 07:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277364AbRJEL6B>; Fri, 5 Oct 2001 07:58:01 -0400
Received: from ns.ithnet.com ([217.64.64.10]:4877 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S277362AbRJEL5w>;
	Fri, 5 Oct 2001 07:57:52 -0400
Date: Fri, 5 Oct 2001 13:58:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem compiling aic7xxx_old.c in 2.4.11-pre4
Message-Id: <20011005135820.0ba7d93e.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still the same:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.11-pre4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o aic7xxx_old.o aic7xxx_old.c
aic7xxx_old.c:11966: parse error before string constant
aic7xxx_old.c:11966: warning: type defaults to `int' in declaration of
`MODULE_LICENSE'
aic7xxx_old.c:11966: warning: function declaration isn't a prototype
aic7xxx_old.c:11966: warning: data definition has no type or storage class
make[3]: *** [aic7xxx_old.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.11-pre4/drivers/scsi'

Regards,
Stephan
