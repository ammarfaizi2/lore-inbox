Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbRFSUsj>; Tue, 19 Jun 2001 16:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264780AbRFSUsa>; Tue, 19 Jun 2001 16:48:30 -0400
Received: from gene.pbi.nrc.ca ([204.83.147.150]:31514 "EHLO gene.pbi.nrc.ca")
	by vger.kernel.org with ESMTP id <S264779AbRFSUsX>;
	Tue, 19 Jun 2001 16:48:23 -0400
Date: Tue, 19 Jun 2001 14:44:19 -0600 (CST)
From: <ognen@gene.pbi.nrc.ca>
To: <linux-kernel@vger.kernel.org>
Subject: threading question (more results)
Message-ID: <Pine.LNX.4.30.0106191443570.16917-100000@gene.pbi.nrc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(for all who are interested)

I finally obtained access to a linux platform running 2.2.17 on a 2x500
Mhz alpha machine (Compaq's testdrive program).

Below are my results:

Linux 2.2.17 on 2x500 Mhz Celerons: parallel app = 1.48 times faster than
sequential one.

Linux 2.4 on a 2x1 Ghz PIIIs: parallel ap = 1.57 times faster than the
sequential one.

Linux 2.2.17 on a 2 500 Mhz Alpha CPUs: parallel app = 1.76 times faster
than the sequential one.

Interesting how hardware changed the numbers. Another interesting thing is
that the same application when run on a dual Alpha running Tru64 does not
obtain the speedup Linux provided on the Alpha hardware.

In my limited example application SGI IRIX 2 CPU platform provided 2.25
times the speed of the sequential application and Sun Solaris 1.99 times
the sequential application (also on a 2 CPU machine). All these numbers
above are when the same code utilizing pthreads was compiled and run on
these various platforms.

On all of the tests I have used a pool of three threads waiting to get
work to do. The testing was done on a set of various sequence files that I
believe represent most of the types of data / sequences that might
be used on this program.

Best regards,
Ognen

-- 
Ognen Duzlevski
Plant Biotechnology Institute
National Research Council of Canada
Bioinformatics team

