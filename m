Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVC2LpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVC2LpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVC2LpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:45:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62372 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262200AbVC2Lnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:43:32 -0500
Subject: Re: sched_setscheduler() and usage issues ....please help
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>,
       Arun Srinivas <getarunsri@hotmail.com>, nickpiggin@yahoo.com.au,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503290802170.25114@yvahk01.tjqt.qr>
References: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl>
	 <1112071215.3691.27.camel@localhost.localdomain>
	 <1112071867.19014.30.camel@mindpipe>
	 <Pine.LNX.4.61.0503290802170.25114@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 13:43:16 +0200
Message-Id: <1112096597.6282.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 08:03 +0200, Jan Engelhardt wrote:
> >> > I am trying to set the SCHED_FIFO  policy for my process.I am using 
> >> > sched_setscheduler() function to do this.
> >> 
> >> Attached is a little program that I use to set the priority of tasks.
> >
> >Why not just use chrt from schedtools?
> 
> Not every distro has it yet, and I like to point out that a lot of users is 
> still using "older" distros, such as FC2, SUSE 9.1, and also olders with Linux 
> 2.4 kernels

FC2 has this. Even FC1 had it, and I'd not be surprised if even RHL9 had
this. I'd be very susprised if SuSE 9.1 doesn't have it either.


