Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWEBKFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWEBKFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 06:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWEBKFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 06:05:36 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:49635 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751256AbWEBKFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 06:05:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=YloSrUym0D24zqdz0GSj1DE0x9b+gG0KuRXHn6r1Xb7yT0VorQoJxrnp30sreWIRVHa1Fqdb2GOTcEzeb4wucjLdgW1CsGzPxuiGGFO8yp20c+PrBp0KnokEiX5UHpx8olYjW/pE3OyGLBvF1iqaNfJfn+uzondPL5qcQY36YpE=
Message-ID: <44572EFD.9070703@gmail.com>
Date: Tue, 02 May 2006 12:05:26 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kasper Sandberg <lkml@metanurb.dk>
CC: LKML Mailinglist <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: [BUG] ACPI bug in 2.6.17-rc3
References: <1146549731.16874.5.camel@localhost>
In-Reply-To: <1146549731.16874.5.camel@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Cc: linux-acpi@vger.kernel.org

Kasper Sandberg napsal(a):
> hello.. just tried out 2.6.17-rc3 on my amd64 system, and i got this
> backtrace:
> khelper pid 4
> trace:
> activate_task+319 try_to_wake_up+93
> __wake_up_common+68 complete+38
> run_workqueue+136 worker_thread+353
> default_wake_function+0 worker_thread+0
> kthread+219 worke_thead+0
> child_rip+8 worker_thread+0
> kthread+0 child_rip+0
> 
> this happened immediately after vesafb changed resolution, i tried
> without vesafb, still the same..
We need whole bug log, no just the trace. Is it possible to grab it?

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEVy79MsxVwznUen4RAp6tAJ9RvSDGtglFtMUW912z3dJQY75mFwCgu5i5
sKbi0EN6YYKmlUo6qcqvU5c=
=CNZM
-----END PGP SIGNATURE-----
