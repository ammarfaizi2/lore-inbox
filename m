Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129976AbRBDJtA>; Sun, 4 Feb 2001 04:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131522AbRBDJsu>; Sun, 4 Feb 2001 04:48:50 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:51148 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129976AbRBDJsg>; Sun, 4 Feb 2001 04:48:36 -0500
To: "J . A . Magallon" <jamagallon@able.es>
Cc: "H . Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
	<m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com>
	<m3puh1que4.fsf@linux.local> <20010202215254.C2498@werewolf.able.es>
	<3A7B1EDC.DA2588BA@transmeta.com> <m3d7d0pwnr.fsf@linux.local>
	<3A7C69AB.9C7603A8@transmeta.com>	<20010203214614.D923@werewolf.able.es>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20010203214614.D923@werewolf.able.es>
Message-ID: <m3vgqqn5ov.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 04 Feb 2001 10:53:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> writes:

> There was a post recently (that now I can't find), that said the shm
> management was done with an interal fs. Was that Posix or sysv shm ?

SYSV shm and shared anonymous mappings are using a kern_mount of
shm/tmpfs. So the CONFIG_TMPFS does only make the
directory/read/write-handling conditional. The rest is unconditionally
compiled into the kernel.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
