Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKQNve>; Fri, 17 Nov 2000 08:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQKQNvO>; Fri, 17 Nov 2000 08:51:14 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:8872 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129069AbQKQNvM>; Fri, 17 Nov 2000 08:51:12 -0500
From: Christoph Rohland <cr@sap.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tigran Aivazian <tigran@veritas.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com>
	<3A152DC1.21B35324@mandrakesoft.com>
Organisation: SAP LinuxLab
Date: 17 Nov 2000 14:21:03 +0100
In-Reply-To: Jeff Garzik's message of "Fri, 17 Nov 2000 08:08:17 -0500"
Message-ID: <qwwlmuivio0.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Fri, 17 Nov 2000, Jeff Garzik wrote:
> IIRC, this came up a long time ago WRT Apache, which made a lot of
> gettimeofday() calls.  Someone (Linus?) proposed the solution of a
> 'magic page' which holds information like gettimeofday() stuff, but
> could be handled much more rapidly than a standard syscall.

Yes, I followed that thread closely and would love to see this as the
implementation for gettimeofday. This would make rdtsc for
applications superfluous.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
