Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUEFLrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUEFLrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 07:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUEFLrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 07:47:20 -0400
Received: from mail.tpgi.com.au ([203.12.160.57]:51851 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261685AbUEFLrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 07:47:18 -0400
Subject: Re: Force IDE cache flush on shutdown
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
In-Reply-To: <20040506113309.GB16548@devserv.devel.redhat.com>
References: <20040506070449.GA12862@devserv.devel.redhat.com>
	 <20040506084918.B12990@infradead.org>
	 <20040506075044.GC12862@devserv.devel.redhat.com>
	 <20040506085549.A13098@infradead.org>
	 <20040506104638.GA9929@devserv.devel.redhat.com>
	 <20040506115220.A14669@infradead.org>
	 <20040506113309.GB16548@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1083843938.22142.6.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Thu, 06 May 2004 21:45:38 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

If you want it tested on some more systems, send it to the suspend list
(swsusp-devel at lists dot sourceforge dot net). There are a bunch of
people there who'd love to give it a go and suspend2 will make any
issues show up quickly. (At the moment, it calls
drivers_suspend() prior to the power off call to force flushing).

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

