Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966272AbWKTRxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966272AbWKTRxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966279AbWKTRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:53:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53665 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S966272AbWKTRxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:53:30 -0500
Date: Mon, 20 Nov 2006 17:59:22 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: multi-function PCI device claiming.
Message-ID: <20061120175922.03708caf@localhost.localdomain>
In-Reply-To: <20061120174130.GA19636@redhat.com>
References: <20061120174130.GA19636@redhat.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 12:41:30 -0500
Dave Jones <davej@redhat.com> wrote:
> What's the correct way to fix this ?

Support a general system for multiple devices sharing a PCI device. AGP
has this problem, EDAC has this problem, serial/parallel ports have a
magic driver hack for it and so on...
