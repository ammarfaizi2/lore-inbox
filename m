Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbRBDJOL>; Sun, 4 Feb 2001 04:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129249AbRBDJOB>; Sun, 4 Feb 2001 04:14:01 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:40137 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129049AbRBDJOA>; Sun, 4 Feb 2001 04:14:00 -0500
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: "J . A . Magallon" <jamagallon@able.es>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
	<m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com>
	<m3puh1que4.fsf@linux.local> <20010202215254.C2498@werewolf.able.es>
	<3A7B1EDC.DA2588BA@transmeta.com> <m3d7d0pwnr.fsf@linux.local>
	<3A7C69AB.9C7603A8@transmeta.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <3A7C69AB.9C7603A8@transmeta.com>
Message-ID: <m3hf2bo5rs.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 04 Feb 2001 10:18:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@transmeta.com> writes:

> Do you need it for POSIX shm or not... if so, I would say you do need it
> (even if it's going to take some time until POSIX shm becomes widely
> used.)

Yes, you need it. glibc 2.2 will search for a shm fs on shm_open. And
without it fails. And the recommendation in the Configure.help is to
mount it.

But you do not need to mount it for any pre 2.4 functionality.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
