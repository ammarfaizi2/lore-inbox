Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTABVuj>; Thu, 2 Jan 2003 16:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267307AbTABVtr>; Thu, 2 Jan 2003 16:49:47 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:27522 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267306AbTABVtc>; Thu, 2 Jan 2003 16:49:32 -0500
Message-ID: <20030102215755.9347.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 03 Jan 2003 05:57:55 +0800
Subject: make pdfdocs/psdocs/htmldocs fail in 2.5.54
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$make pdfdocs

make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=Documentation/DocBook pdfdocs
db2pdf -o Documentation/DocBook/ Documentation/DocBook/parportbook.sgml
jw: Please specify at least one catalog
make[1]: *** [Documentation/DocBook/parportbook.pdf] Error 4
make: *** [pdfdocs] Error 2

Ciao,
        Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
