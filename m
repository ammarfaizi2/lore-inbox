Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRBMUxO>; Tue, 13 Feb 2001 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBMUxE>; Tue, 13 Feb 2001 15:53:04 -0500
Received: from smtp9.xs4all.nl ([194.109.127.135]:10976 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129664AbRBMUwq>;
	Tue, 13 Feb 2001 15:52:46 -0500
From: thunder7@xs4all.nl
Date: Tue, 13 Feb 2001 21:51:58 +0100
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, keil@isdn4linux.de
Subject: 2.2.19pre10 locks up hard on unloading the isdn module 'hisax.o'
Message-ID: <20010213215158.A967@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SMP machine, 2x P3/700 on an Abit VP6.
Never any trouble with the earlier 2.2.19pre's.

a strace shows the hang to be in the delete_module("hisax") call.

I'm having trouble with the sysrq-key, but I hope this is enough since
there were some changes w.r.t. modules/locking etc. in pre10.

Good luck,
Jurriaan
-- 
The guy sure looks like plantfood to me
	Little Shop of Horrors
GNU/Linux 2.2.19pre10 SMP/ReiserFS 2x1402 bogomips load av: 0.02 0.05 0.05
