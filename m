Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSHXTMU>; Sat, 24 Aug 2002 15:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSHXTMU>; Sat, 24 Aug 2002 15:12:20 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:58272 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S316610AbSHXTMT>; Sat, 24 Aug 2002 15:12:19 -0400
Message-ID: <20020824191628.17121.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: rcastro@users.sourceforge.net
Date: Sun, 25 Aug 2002 03:16:28 +0800
Subject: dbench test
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've just ran a few test "dbench" based against:
- 2.4.18
- 2.4.18 + compressed cache -0.24pre3
- 2.4.19
- 2.5.31

Ok, I know that dbench is not a "good" test,
but it should be at least a good stress test.
I got neither oops nor BUG().

Each test has been ran twice.
Here it goes the results:

2.4.18
Istances Throughput
8 	 25.1022
16 	 20.3833
24 	 18.0078
32 	 13.6657

2.4.18 -0.24pre3 (64MiB of cc)
Istances Throughput
8 	 28.5116
16 	 27.5003
24 	 24.6963
32 	 16.423

2.4.19
Istances Throughput
8 	 25.5343
16 	 20.7133
24 	 16.2473
32 	 14.2351

2.5.31
Istances Throughput
8 	 30.6827
16 	 18.2236
24 	 14.6759
32 	 12.7659

Ciao,
         Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
