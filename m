Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRBCOZS>; Sat, 3 Feb 2001 09:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbRBCOZJ>; Sat, 3 Feb 2001 09:25:09 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:26351 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129143AbRBCOYw>; Sat, 3 Feb 2001 09:24:52 -0500
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: "J . A . Magallon" <jamagallon@able.es>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
	<m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com>
	<m3puh1que4.fsf@linux.local> <20010202215254.C2498@werewolf.able.es>
	<3A7B1EDC.DA2588BA@transmeta.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <3A7B1EDC.DA2588BA@transmeta.com>
Message-ID: <m3d7d0pwnr.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 03 Feb 2001 15:28:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@transmeta.com> writes:

> > Mmmmmm, does this mean that mounting /dev/shm is no more needed ?
> > One step more towards easy 2.2 <-> 2.4 switching...

Yes, it is no longer needed. You will need for POSIX shm, but there
are not a lot of program out there using it.

> In some ways it's kind of sad.  I found the /dev/shm interface to be
> rather appealing :)

I totally agree :(

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
