Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVL2MQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVL2MQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 07:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVL2MQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 07:16:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10164 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750709AbVL2MQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 07:16:07 -0500
Subject: Re: Redefinition error while compiling LKM
From: Arjan van de Ven <arjan@infradead.org>
To: Alexander Shishckin <alexander.shishckin@gmail.com>
Cc: "pretorious ." <pretorious_i@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <71a0d6ff0512290414i3e8cc67bi633b8b76fe56336a@mail.gmail.com>
References: <BAY23-F27F5FACE353137AF8C88F8F7290@phx.gbl>
	 <1135856947.2935.17.camel@laptopd505.fenrus.org>
	 <71a0d6ff0512290414i3e8cc67bi633b8b76fe56336a@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 13:16:03 +0100
Message-Id: <1135858564.2935.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 15:14 +0300, Alexander Shishckin wrote:
> On 12/29/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Thu, 2005-12-29 at 16:51 +0530, pretorious . wrote:
> > > >
> > > >and.. why on earth would you need sys/syscall.h ?? (or sys/stat.h for
> > > >that matter)
> > > >
> > > >
> > >
> > > Trying to override certain syscalls (mknod ...)
> >
> > eeppp why??
> > really don't do that!
> >
> > (overriding syscalls from modules really shouldn't be done.. there's a
> > reason the syscall table isn't exported!)
> 
> Perhaps during the 2.4.21 old days sys_call_table was still exported

not in the RHEL3 kernel though.


