Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKQNW0>; Fri, 17 Nov 2000 08:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129720AbQKQNWB>; Fri, 17 Nov 2000 08:22:01 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:1428 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129097AbQKQNVy>; Fri, 17 Nov 2000 08:21:54 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tigran@veritas.com (Tigran Aivazian), mikpe@csd.uu.se (Mikael Pettersson),
        ledzep37@home.com (Jordan),
        linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: 17 Nov 2000 13:51:11 +0100
In-Reply-To: Alan Cox's message of "Fri, 17 Nov 2000 12:10:07 +0000 (GMT)"
Message-ID: <qwwpujuvk1s.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Fri, 17 Nov 2000, Alan Cox wrote:
> Even checking the cpuinfo for the TSC should be done with care, and
> its far far better to use gettimeofday unless doing very tiny
> timings (eg for optimising code paths)

gettimeofday is _way_ to slow for a lot of every day uses. So
applications will use rdtsc until we have some really fast
(non-syscall) way to have high resolution time diffs.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
