Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270898AbRHNWW4>; Tue, 14 Aug 2001 18:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270880AbRHNWWq>; Tue, 14 Aug 2001 18:22:46 -0400
Received: from web14509.mail.yahoo.com ([216.136.224.168]:21769 "HELO
	web14509.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270898AbRHNWWi>; Tue, 14 Aug 2001 18:22:38 -0400
Message-ID: <20010814222235.95626.qmail@web14509.mail.yahoo.com>
Date: Tue, 14 Aug 2001 15:22:35 -0700 (PDT)
From: Kent Hunt <kenthunt@yahoo.com>
Subject: Thanks!! SMP+emu10k1+2.4.9-pre1 == no lockups after 2 years
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After almost 2 years using 2.4 kernels since the test
ones I finally can say that my SMP box is rock solid.
I was experiencing hard lockups without any oops in
some sporadic but very particular situations: creation
and destruction of gtk+ objects. I thought that the
problem was either X or G400 video card. It turned out
that it was the emu10k1 driver which I decided to
unload after reading a recent post of Eric S. Raymond
using Tyan K7 Thunder dual-Athlon. After unloading the
driver I was not 
able to crash my box anymore. So it was not the gtk+
the problem but was the little sound events generated
during the creation and destruction of objects. The
new driver in 2.4.9-pre1 is solid for me. I hope that
you keep this one and thanks for fixing it! My SMP
mobo is ASUS P2BD with PIII's. 

Kent


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
