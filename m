Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268817AbRHFVDk>; Mon, 6 Aug 2001 17:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbRHFVDa>; Mon, 6 Aug 2001 17:03:30 -0400
Received: from r85m244.cybercable.tm.fr ([195.132.85.244]:20352 "HELO
	picsou.chatons") by vger.kernel.org with SMTP id <S268817AbRHFVDZ>;
	Mon, 6 Aug 2001 17:03:25 -0400
Date: Mon, 6 Aug 2001 23:03:35 +0200
From: David Monniaux <monniaux.remove_me_this_for_spam@di.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: APM poweroff under Linux 2.4.7 / 2.4.2 RH 7.1
Message-ID: <20010806230335.A2473@picsou.chatons>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have an Athlon on an ASUS A7V133.
This machine powers off perfectly using a stock RedHat 7.1 kernel (2.4.2).
However, it refuses to power off with 2.4.7, with all APM options set
correctly (including power off in real mode).

Now for the funny part: copying the 2.4.2 apm.c to the 2.4.7 and
recompiling yielded a working poweroff. So *something* has been broken
between 2.4.2 and 2.4.7 with APM poweroff. :-)

-- 
David Monniaux            http://www.di.ens.fr/~monniaux
Laboratoire d'informatique de l'École Normale Supérieure,
Paris, France
