Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTLEXJD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTLEXJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:09:03 -0500
Received: from pop.gmx.de ([213.165.64.20]:40342 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264890AbTLEXI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:08:59 -0500
Date: Sat, 6 Dec 2003 00:08:58 +0100 (MET)
From: "Peter Bergmann" <bergmann.peter@gmx.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, nfedera@esesix.at
MIME-Version: 1.0
References: <Pine.LNX.4.44.0312051702010.5412-100000@logos.cnet>
Subject: Re: old oom-vm for 2.4.32 (was oom killer in 2.4.23)
X-Priority: 3 (Normal)
X-Authenticated: #13246506
Message-ID: <16204.1070665738@www29.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If anyone  is interested:
> > Norbert Federa sent me this link for a "quick&dirty" patch he made 
> > for 2.4.23-vanilla which rolls back the complete 2.4.22 vm including the
> > old oom-killer  - without guarantee but it does work very well for me
> ...
> 
> I suppose the oom killer is the only reason for you using .22 VM correct?
> 
> Or do you have any other reason for this?

No, you're right. The oom killer is the _only_reason. 
I did not succeed in integrating the disabled oom_kill.c in 2.4.23.
The only solution for me is applying Norbert's .22vm patch.

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


