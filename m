Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282895AbRK0KCz>; Tue, 27 Nov 2001 05:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282893AbRK0KCp>; Tue, 27 Nov 2001 05:02:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61196 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282892AbRK0KC0>; Tue, 27 Nov 2001 05:02:26 -0500
Subject: Re: [PATCH] proc-based cpu affinity user interface
To: mingo@elte.hu
Date: Tue, 27 Nov 2001 10:10:34 +0000 (GMT)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.33.0111271247120.9992-100000@localhost.localdomain> from "Ingo Molnar" at Nov 27, 2001 12:52:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168fCE-0000X7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fundamental limitation of your approach, and *if* we want to export the
> cpus_allowed affinity to user-space (which is up to discussion), then the
> right way (TM) to do it is via a syscall.

HP and others have already implemented chunks of this stuff via syscall
interfaces. There is a complete pset api.

Alan
