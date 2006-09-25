Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWIYXug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWIYXug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWIYXuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:50:35 -0400
Received: from khc.piap.pl ([195.187.100.11]:214 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751566AbWIYXuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:50:35 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NV SATA breakage: jgarzik/libata-dev#upstream etc
References: <m3wt7tm6sh.fsf@defiant.localdomain> <451721F8.4060600@pobox.com>
	<m3vencjeit.fsf@defiant.localdomain>
	<m364fbrhow.fsf@defiant.localdomain> <45185625.4050906@pobox.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 26 Sep 2006 01:50:32 +0200
In-Reply-To: <45185625.4050906@pobox.com> (Jeff Garzik's message of "Mon, 25 Sep 2006 18:20:21 -0400")
Message-ID: <m3fyef1p6f.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Krzysztof Halasa wrote:
>> 	ppi[0] = ppi[1] = &nv_port_info[ent->driver_data];
>
> That's probably the best solution.

It fixes the SATA NV problem (I'm not attaching the patch as you already
posted similar one).
-- 
Krzysztof Halasa
