Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVF1HmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVF1HmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVF1HlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:41:19 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:15772 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261571AbVF1Hjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:39:55 -0400
Date: Tue, 28 Jun 2005 09:39:36 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andreas Kies <andikies@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Bug in gcc or asm/string.h ?
Message-ID: <20050628093936.2327c11c@localhost>
In-Reply-To: <200506280153.04620.andikies@t-online.de>
References: <200506270105.28782.andikies@t-online.de>
	<200506272059.20477.andikies@t-online.de>
	<20050627214315.4b8850f5@localhost>
	<200506280153.04620.andikies@t-online.de>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005 01:53:04 +0200
Andreas Kies <andikies@t-online.de> wrote:

> Now, how do i formally submit this as a bug report ?

Not needed.

Linus has just fix it by adding "memory" to clobbered registers:

	http://marc.theaimsgroup.com/?l=bk-commits-head&m=111965412113339&w=2

--
	Paolo Ornati
	Linux 2.6.12.1 on x86_64
