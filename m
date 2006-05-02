Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWEBPJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWEBPJq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWEBPJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:09:46 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:46791 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S964868AbWEBPJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:09:45 -0400
Subject: Re: [BUG] ACPI bug in 2.6.17-rc3
From: Kasper Sandberg <lkml@metanurb.dk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
In-Reply-To: <44572EFD.9070703@gmail.com>
References: <1146549731.16874.5.camel@localhost>
	 <44572EFD.9070703@gmail.com>
Content-Type: text/plain
Date: Tue, 02 May 2006 17:09:44 +0200
Message-Id: <1146582584.7183.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 12:05 +0159, Jiri Slaby wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Cc: linux-acpi@vger.kernel.org
> 
> Kasper Sandberg napsal(a):
> > hello.. just tried out 2.6.17-rc3 on my amd64 system, and i got this
> > backtrace:
> > khelper pid 4
> > trace:
> > activate_task+319 try_to_wake_up+93
> > __wake_up_common+68 complete+38
> > run_workqueue+136 worker_thread+353
> > default_wake_function+0 worker_thread+0
> > kthread+219 worke_thead+0
> > child_rip+8 worker_thread+0
> > kthread+0 child_rip+0
> > 
> > this happened immediately after vesafb changed resolution, i tried
> > without vesafb, still the same..
> We need whole bug log, no just the trace. Is it possible to grab it?
this is all i get..
> 
> thanks,
> - --
> Jiri Slaby         www.fi.muni.cz/~xslaby
> \_.-^-._   jirislaby@gmail.com   _.-^-._/
> B67499670407CE62ACC8 22A032CC55C339D47A7E
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.3 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFEVy79MsxVwznUen4RAp6tAJ9RvSDGtglFtMUW912z3dJQY75mFwCgu5i5
> sKbi0EN6YYKmlUo6qcqvU5c=
> =CNZM
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

