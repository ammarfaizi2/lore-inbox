Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWGDIJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWGDIJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWGDIJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:09:12 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:61453 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751091AbWGDIJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:09:10 -0400
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Rich Townsend <rhdt@bartol.udel.edu>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: RFC [PATCH] acpi: allow SMBus access
References: <17576.14005.767262.868190@phoenix.squirrel.nl>
	<20060703082217.GB17014@poupinou.org>
	<m2mzbrj5yp.fsf@phoenix.squirrel.nl>
	<20060703125156.GD17014@poupinou.org>
From: Johan Vromans <jvromans@squirrel.nl>
Date: Tue, 04 Jul 2006 10:09:06 +0200
In-Reply-To: <20060703125156.GD17014@poupinou.org> (Bruno Ducrot's message
 of "Mon, 3 Jul 2006 14:51:56 +0200")
Message-ID: <m2d5cln659.fsf@phoenix.squirrel.nl>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Ducrot <ducrot@poupinou.org> writes:

> I wanted to provide a real bus access via the EC driver, including
> the interrupt driven ones.

Yes, that would be the right way to go. But it is a longer term
solution and AFAIK noone is currently working on it.

In the mean time, several users can benefit from an intermediate
solution like the one I suggested. Besides, it is not a wrong solution
per se, it is equally wrong as the ac_read/write routines that are
exported.

So I still think that exporting the current acpi_ec_read/write would
be a good thing to so, but I agree it should be marked as an
intermediate solution.

-- Johan
