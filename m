Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281237AbRKPINz>; Fri, 16 Nov 2001 03:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281240AbRKPINp>; Fri, 16 Nov 2001 03:13:45 -0500
Received: from dns.irisa.fr ([131.254.254.2]:47521 "HELO dns.irisa.fr")
	by vger.kernel.org with SMTP id <S281237AbRKPINb>;
	Fri, 16 Nov 2001 03:13:31 -0500
Date: Fri, 16 Nov 2001 09:13:30 +0100
From: DINH Viet Hoa <Viet-Hoa.Dinh@irisa.fr>
To: linux-kernel@vger.kernel.org
Subject: programs mapping in memory
Message-Id: <20011116091330.627cd194.vdinh@irisa.fr>
Organization: IRISA
X-Mailer: Sylpheed version 0.6.5claws12 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I am on the bad mailing-list but my question is
the following : Why are programs mapped into memory
segments that start around 0x8048000 ?
How is it chosen and why is this choice made ?
For example, why couldn't is be 0x1000000 ?

for example :

% cat /proc/1/maps 
08048000-0804f000 r-xp 00000000 08:01 6078       /sbin/init
0804f000-08050000 rw-p 00006000 08:01 6078       /sbin/init
08050000-08054000 rwxp 00000000 00:00 0
...
bfffe000-c0000000 rwxp fffff000 00:00 0

(Version of linux is 2.2.13)

thanks for your answers.

-- 
DINH Viêt Hoà, ingénieur associé, projet PARIS
IRISA-INRIA, Campus de Beaulieu, 35042 Rennes cedex, France
Tél: +33 (0) 2 99 84 75 98, Fax: +33 (0) 2 99 84 25 28
