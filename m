Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSHCMXI>; Sat, 3 Aug 2002 08:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSHCMXH>; Sat, 3 Aug 2002 08:23:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24817 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317541AbSHCMXH>; Sat, 3 Aug 2002 08:23:07 -0400
Subject: Re: how do i integrate my winmodem driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hell.Surfers@cwctv.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0ca6d3103010382DTVMAIL6@smtp.cwctv.net>
References: <0ca6d3103010382DTVMAIL6@smtp.cwctv.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 14:44:27 +0100
Message-Id: <1028382267.31733.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That depends extensively on the nature of the card. IBM's mwave is
pretty intelligent so the logic is all kernel side. For a dumb winmodem
like the intel 8x0 AC97 stuff it actually makes little sense to put more
in the kernel than the most time critical bits (echo cancellation etc).

It depends what the modem does and doesn't handle itself

