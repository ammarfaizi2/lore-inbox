Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757854AbWK0PCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757854AbWK0PCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758268AbWK0PCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:02:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43200 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757648AbWK0PCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:02:01 -0500
Date: Mon, 27 Nov 2006 15:08:37 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       stable@vger.kernel.org
Subject: Re: [PATCH] IDE: typo in ide-io.c leads to faulty assignment
Message-ID: <20061127150837.336f5541@localhost.localdomain>
In-Reply-To: <87k61h3pu2.fsf@denkblock.local>
References: <87k61h3pu2.fsf@denkblock.local>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 15:51:33 +0100
Elias Oltmanns <eo@nebensachen.de> wrote:

> Due to a typo in ide_start_power_step, the result of a function rather
> than its pointer is assigned to args->handler.

NAK

If it was the result of the function it would end with (arguments);

Alan
