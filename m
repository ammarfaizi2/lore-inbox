Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272108AbRIEKz0>; Wed, 5 Sep 2001 06:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272099AbRIEKzP>; Wed, 5 Sep 2001 06:55:15 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:4362 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S272094AbRIEKzC>; Wed, 5 Sep 2001 06:55:02 -0400
Message-Id: <200109051055.f85AtGe15458@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: reliable debug output
Date: Wed, 5 Sep 2001 12:55:15 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when debugging drivers using printk i've the problem that most often 
the msg passed to printk don't show up on the console since the machine 
crashed before. i also what to use my own ASSERT macros which halt the 
machine immediatly on an error. i could write some functions that write 
the debug string to the serial port but this is impractical since if've 
a cluster of pc and i can't connect them all to some serial lines for 
debugging. are there some functions which write directly into the graphic 
cards ram assuming that thy operate in console mode, no x-server running?
or is ther any other way to for reliable debug prints.
