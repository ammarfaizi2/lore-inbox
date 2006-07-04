Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWGDLo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWGDLo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWGDLo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:44:58 -0400
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:48398 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP id S932217AbWGDLo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:44:57 -0400
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Johan Vromans <jvromans@squirrel.nl>, Rich Townsend <rhdt@bartol.udel.edu>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: RFC [PATCH] acpi: allow SMBus access
References: <17576.14005.767262.868190@phoenix.squirrel.nl>
	<20060703082217.GB17014@poupinou.org>
	<m2mzbrj5yp.fsf@phoenix.squirrel.nl>
	<20060703125156.GD17014@poupinou.org>
	<m2d5cln659.fsf@phoenix.squirrel.nl>
	<20060704093510.GG17014@poupinou.org>
From: Johan Vromans <jvromans@squirrel.nl>
Date: Tue, 04 Jul 2006 13:44:53 +0200
In-Reply-To: <20060704093510.GG17014@poupinou.org> (Bruno Ducrot's message
 of "Tue, 4 Jul 2006 11:35:10 +0200")
Message-ID: <m24pxxmw5m.fsf@phoenix.squirrel.nl>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Ducrot <ducrot@poupinou.org> writes:

> An intermediate solution would be to use the already existing
> ec_read|write instead of the one you want to use.  The original
> SMBus driver used acpi_ec_read because the author wanted to be
> sure that driver will support laptops with more than one EC, but
> he never saw such laptops so far.

Indeed, if the requirement for multiple ECs can be dropped, this
simplifies the problem sufficiently to use the current ec_read/write
functions.

Unless someone comes up with other ideas I suggest to withdraw this
proposal until laptops with multiple ECs hit the market...

-- Johan


