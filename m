Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbULPLaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbULPLaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 06:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbULPLa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 06:30:29 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:11968 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262630AbULPLa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 06:30:26 -0500
Date: Thu, 16 Dec 2004 12:30:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: USB making time drift [was Re: dynamic-hz]
Message-ID: <20041216113001.GJ28286@dualathlon.random>
References: <20041213002751.GP16322@dualathlon.random> <200412151144.38785.gene.heskett@verizon.net> <20041215182012.GH16322@dualathlon.random> <200412152059.52292.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412152059.52292.gene.heskett@verizon.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 08:59:52PM -0500, Gene Heskett wrote:
> Unforch, I was not able to find that in the .config file, so where is
> that particular option set?

There is no config option indeed, you need to edit
include/asm-i386/param.h to change HZ.
