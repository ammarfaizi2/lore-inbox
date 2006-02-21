Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161428AbWBUISE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161428AbWBUISE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161424AbWBUISE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:18:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62604 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161428AbWBUISC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:18:02 -0500
Subject: Re: irq balance problems?
From: Arjan van de Ven <arjan@infradead.org>
To: Imre Gergely <imre.gergely@astral.ro>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FAC963.40908@astral.ro>
References: <43FAC5AA.1030205@astral.ro>
	 <1140508579.3082.12.camel@laptopd505.fenrus.org> <43FAC963.40908@astral.ro>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 09:18:00 +0100
Message-Id: <1140509881.3082.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 10:03 +0200, Imre Gergely wrote:
> 
> Arjan van de Ven wrote:
> >> and irqbalance is not running, why aren't the interrupts coming from eth0
> >> balanced between the two processors? at least that's what i understood from the
> >> examples in Documentation/IRQ-affinity.txt. are there any other settings/kernel
> >> parameters/compile option one has to set?
> > 
> > it'll depend on the chipset. Some round-robin, some don't.
> > For performance it's better to not round-robin. 
> 
> is there a way to see for sure? or this behaviour is proof enough that it
> doesn't do round-robin?

it's pretty much proof to me already yes ;)

(but why do you want round-robin? it's the worst setting for
performance..... )

