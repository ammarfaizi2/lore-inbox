Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVAKHrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVAKHrB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 02:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVAKHrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 02:47:00 -0500
Received: from canuck.infradead.org ([205.233.218.70]:26374 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262477AbVAKHqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 02:46:14 -0500
Subject: Re: Preemptible Big Kernel Lock?
From: Arjan van de Ven <arjan@infradead.org>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050110172910.F49234@x9.ybpnyarg>
References: <20050110172910.F49234@x9.ybpnyarg>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 08:46:03 +0100
Message-Id: <1105429563.3917.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 17:48 -0800, walt wrote:

> Would I expect to see a difference on a uni-processor
> machine?  (That's all I have.)
> 

humans in general don't notice things < 1 milisecond. The preemptable
BKL and other latency fixes are (most) there to reduce the existing
typical latency that is < 1 msec to something even far lower. (and the
maximum which is a bit above 1 msec to below it.. but that you hardly
ever trigger unless you try).
So I doubt that you as human will perceive this.
Professional audio applications might notice though..,. ;)

