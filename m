Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285170AbRLRVKd>; Tue, 18 Dec 2001 16:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285174AbRLRVKW>; Tue, 18 Dec 2001 16:10:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44434 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285166AbRLRVJz>;
	Tue, 18 Dec 2001 16:09:55 -0500
Date: Tue, 18 Dec 2001 13:08:50 -0800 (PST)
Message-Id: <20011218.130850.26927886.davem@redhat.com>
To: Mika.Liljeberg@welho.com
Cc: kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi,
        rmk@arm.linux.ORG.UK
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C1FAC8F.699E1287@welho.com>
In-Reply-To: <200112182029.XAA11287@ms2.inr.ac.ru>
	<3C1FAC8F.699E1287@welho.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mika Liljeberg <Mika.Liljeberg@welho.com>
   Date: Tue, 18 Dec 2001 22:52:31 +0200
   
   Ahh, I see. There's a kernel exception handler that is supposed to fix
   misaligned access? Hacky.

Not hacky, "transparent".  It allows us to fast-path everything.
