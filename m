Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131194AbQLMQqZ>; Wed, 13 Dec 2000 11:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131228AbQLMQqO>; Wed, 13 Dec 2000 11:46:14 -0500
Received: from mout1.freenet.de ([194.97.50.132]:21721 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S131194AbQLMQqD>;
	Wed, 13 Dec 2000 11:46:03 -0500
From: mkloppstech@freenet.de
Message-Id: <200012131614.RAA02997@john.epistle>
Subject: Re: 2.4.0-test12 unresolved SCSI symbols
In-Reply-To: <m145pPT-0005keC@gherkin.sa.wlk.com> from Bob_Tracy at "Dec 12,
 2000 07:23:59 am"
To: Bob_Tracy <rct@gherkin.sa.wlk.com>
Date: Wed, 13 Dec 2000 17:14:10 +0100 (CET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Someone else mentioned the problem in a different context, so
> this report isn't exactly new...  LOTS of unresolved symbols in
> several SCSI modules.  Here's the list for "st.o":

> Other modules I'm personally having problems with are "sg.o" and
> "sr_mod.o".  I'll have a look and see if there's a quick fix if
> someone doesn't beat me to the punch.

mv .config ..
make mrproper
mv ../.config .
make menuconfig, exit
make dep
etc.


Mirko Kloppstech
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
