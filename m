Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbTBYK3C>; Tue, 25 Feb 2003 05:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267904AbTBYK3C>; Tue, 25 Feb 2003 05:29:02 -0500
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:54761 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S267902AbTBYK3B>; Tue, 25 Feb 2003 05:29:01 -0500
Date: Tue, 25 Feb 2003 11:34:29 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: linux-kernel@vger.kernel.org
Subject: /proc/net/dev with tg3 and 2.4.19
Message-ID: <20030225113429.C1866@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With tg3 from 2.4.19 the Recieve/Transmit-bytes entries grow to 4294967295, 
but then stay at this value. This isn't the expected behaviour, is it? All 
other net drivers will jump back to zero and count up again, won't they?
Is there a patch available?
Otherwise 2.4.19's tg3 seems pretty stable to me, as it's running since 2002 
Oct. 7th with no problems...

Christian

