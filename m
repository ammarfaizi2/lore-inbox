Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933256AbWKSUpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256AbWKSUpu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933257AbWKSUpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:45:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:22183 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933256AbWKSUpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:45:49 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <4560C1C6.8000203@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <20061119202348.GA27649@elte.hu>  <4560BF28.8010406@ru.mvista.com>
	 <1163968570.5826.113.camel@localhost.localdomain>
	 <4560C1C6.8000203@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:45:53 +1100
Message-Id: <1163969153.5826.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    Yeah, that's what the threaded versions of flow handlers are doing. Except 
> they're calling ack() to actually EOI an IRQ.

Ok well, them the fix is to fix them not the PIC code :-)

Ben.


