Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWBFKIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWBFKIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWBFKIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:08:16 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:25740 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750905AbWBFKIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:08:16 -0500
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <43E71AD7.5070600@shaolinmicro.com>
From: Jes Sorensen <jes@sgi.com>
Date: 06 Feb 2006 05:08:13 -0500
In-Reply-To: <43E71AD7.5070600@shaolinmicro.com>
Message-ID: <yq0d5i0ol4i.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Chow <davidchow@shaolinmicro.com> writes:

David> Dear maintainers, Is there any work in Linux undergoing to
David> separate Linux drivers and the the main kernel, and manage
David> drivers using a package management system that only manages
David> kernel drivers and modules? If this can be done, the kernel
David> maintenance can be simple, and will end-up with a more stable
David> (less frequent changed) kernel API for drivers, also make every
David> developers of drivers happy.

David> Would like to see that happens .

Simple answer: no

Maybe someone is working on it, but it's highly unlikely to be
anything but a waste of that person's time.

This is a classic question, by seperating out the drivers you make it
so much harder for all developers to propagate changes into all pieces
of the tree.

Cheers,
Jes
