Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263719AbUCVWWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbUCVWWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:22:23 -0500
Received: from mail.tpgi.com.au ([203.12.160.59]:13230 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263719AbUCVWWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:22:21 -0500
Subject: Re: swsusp 2.0 with kernel 2.6.4, failure to suspend (vaio fx701)
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: romano@dea.icai.upco.es
Cc: Romano Giannetti <romano@pern.dea.icai.upco.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20040322100521.GA26767@pern.dea.icai.upco.es>
References: <20040322100521.GA26767@pern.dea.icai.upco.es>
Content-Type: text/plain
Message-Id: <1079990542.2770.25.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 23 Mar 2004 09:22:22 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thanks for the report; The end of your log shows us that it was
saslauthd that was causing the freezing failure. I'll look at what
adjustments would fix that issue.

Regarding getting more debugging info, you need to use debug_sections as
well as the default_console_level; the console level says how much
information you want. debug_sections says what information you want.
(Suspend it capable of printing an awful lot of debugging info; usually
we're only interested in one particular area).

Regards,

Nigel
   
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

