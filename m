Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313896AbSEHMge>; Wed, 8 May 2002 08:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313902AbSEHMgd>; Wed, 8 May 2002 08:36:33 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:59141 "HELO k2.dsa-ac.de")
	by vger.kernel.org with SMTP id <S313896AbSEHMgd>;
	Wed, 8 May 2002 08:36:33 -0400
Date: Wed, 8 May 2002 14:36:17 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Cc: <tytso@mit.edu>, <linux-serial@vger.kernel.org>
Subject: 16850 automatic RTS/CTS
Message-ID: <Pine.LNX.4.33.0205081424330.2626-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

As of 2.5.6 there is some support in the serial driver for the 16850
automatic hardware handshake feature, in particular the automatic CTS is
enabled, but not the automatic RTS. Nor are the hysteresis levels set.
Why? I tried enabling all these features, it helps a good deal improving
the reliability of the data transfer, but still, at high baud-rates
(460800, 921600) and in the presence of user-space load data can be
overwritten in the driver's buffer. Why isn't this checked?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany


