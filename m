Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271899AbRIDHsD>; Tue, 4 Sep 2001 03:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271902AbRIDHrx>; Tue, 4 Sep 2001 03:47:53 -0400
Received: from csp.org.by ([194.85.255.136]:31500 "EHLO babbler.csp.org.by")
	by vger.kernel.org with ESMTP id <S271899AbRIDHrg>;
	Tue, 4 Sep 2001 03:47:36 -0400
Date: Tue, 4 Sep 2001 10:51:55 +0300
From: Artiom Morozov <apm@csp.org.by>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: invalid depmod flag
Message-ID: <20010904105155.A8586@cyan>
Reply-To: apm@csp.org.by
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fair day to ye,

during 
make modules_install

depmod fails because flags -F is invalid and should be replaced with -m
(imho!).

Kernel 2.4.6
depmod 2.1.121

-- 
WEB SPACE STATION
Web Design and Software Development
E-mail: apm@csp.org.by
http://www.web-space-station.com

