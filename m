Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBBJxE>; Fri, 2 Feb 2001 04:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129035AbRBBJwz>; Fri, 2 Feb 2001 04:52:55 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:50400 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129028AbRBBJwu>; Fri, 2 Feb 2001 04:52:50 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
	<m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <95csna$vb6$1@cesium.transmeta.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
Date: 02 Feb 2001 10:57:55 +0100
Message-ID: <m3puh1que4.fsf@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> What happened with this being a management tool for shared memory
> segments?!

Unfortunately we lost this ability in the 2.4.0-test series. SYSV shm
now works only on an internal mounted instance and does not link the
directory entry to the deleted state of the segment. 

IMNSHO the new implementation is so much cleaner that it was worth
it. Probably we should fix ipcrm to be more flexible.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
