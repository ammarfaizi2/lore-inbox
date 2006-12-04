Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936957AbWLDPHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936957AbWLDPHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936937AbWLDPHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:07:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:57802 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
	id S936957AbWLDPHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:07:08 -0500
Date: Mon, 4 Dec 2006 15:12:54 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_via: add VT6421 PATA support
Message-ID: <20061204151254.540ffe43@localhost.localdomain>
In-Reply-To: <45742FFA.6020604@wpkg.org>
References: <45742FFA.6020604@wpkg.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2006 15:26:02 +0100
Tomasz Chmielewski <mangoo@wpkg.org> wrote:

> his patch adds VT6421 PATA support to sata_via.

NAK

This shouldn't be compile time
It doesn't handle MWDMA properly
It uses the old error/reset code

