Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWBUH40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWBUH40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 02:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWBUH40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 02:56:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52654 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751135AbWBUH4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 02:56:25 -0500
Subject: Re: irq balance problems?
From: Arjan van de Ven <arjan@infradead.org>
To: Imre Gergely <imre.gergely@astral.ro>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FAC5AA.1030205@astral.ro>
References: <43FAC5AA.1030205@astral.ro>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 08:56:19 +0100
Message-Id: <1140508579.3082.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> and irqbalance is not running, why aren't the interrupts coming from eth0
> balanced between the two processors? at least that's what i understood from the
> examples in Documentation/IRQ-affinity.txt. are there any other settings/kernel
> parameters/compile option one has to set?

it'll depend on the chipset. Some round-robin, some don't.
For performance it's better to not round-robin. 


