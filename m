Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTETSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbTETSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:07:57 -0400
Received: from birosca.ime.usp.br ([143.107.45.59]:43983 "HELO
	birosca.ime.usp.br") by vger.kernel.org with SMTP id S263763AbTETSH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:07:56 -0400
Date: Tue, 20 May 2003 15:20:53 -0300
From: Alex Pires de Camargo <acamargo@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21rc2 NET Messages
Message-ID: <20030520182052.GK30926@ime.usp.br>
Reply-To: linux-kernel@vger.kernel.org,
       Alex Pires de Camargo <acamargo@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi. You ask to test rcs kernel, so...
	I'm getting lots of:

May 20 07:57:10 kama kernel: hw tcp v4 csum failed
May 20 07:57:20 kama last message repeated 11 times
May 20 07:57:25 kama kernel: NET: 6 messages suppressed.
May 20 07:57:25 kama kernel: hw tcp v4 csum failed
May 20 07:57:30 kama kernel: NET: 8 messages suppressed.
May 20 07:57:30 kama kernel: hw tcp v4 csum failed
May 20 07:57:37 kama kernel: NET: 8 messages suppressed.
May 20 07:57:37 kama kernel: hw tcp v4 csum failed
May 20 07:57:43 kama kernel: NET: 4 messages suppressed.
May 20 07:57:43 kama kernel: hw tcp v4 csum failed

	in my syslog.

	It's a production machine, so i could not try other kernel versions.
	I'm running 2.4.21-rc2, with intel e100 network driver, on a SMP box
with HIGHMEM (6gb).
	I have another SMP box, with HIGHMEM (3,5gb), 3c59x network driver,
with rc2 too, that does not have this problem.

	Cheers,

*************************************************************************
* Alex Pires de Camargo                 *      Debian GNU/Linux         *
* e-mail:acamargo@ime.usp.br            * The biggest is still the best *
* http://www.ime.usp.br/~acamargo       *    http://www.debian.org      *
*************************************************************************
