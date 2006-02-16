Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWBPRmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWBPRmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWBPRmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:42:25 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:7623 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751388AbWBPRmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:42:25 -0500
Subject: Re: (pspace,pid) vs true pid virtualization
From: Dave Hansen <haveblue@us.ibm.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
In-Reply-To: <20060216143030.GA27585@MAIL.13thfloor.at>
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	 <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	 <20060216143030.GA27585@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 09:41:32 -0800
Message-Id: <1140111692.21383.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 15:30 +0100, Herbert Poetzl wrote:
> > - Should a process have some sort of global (on the machine identifier)?
> 
> this is mandatory, as it is required to kill any process
> from the host (admin) context, without entering the pid
> space (which would lead to all kind of security issues) 

Giving admin processes the ability to enter pid spaces seems like it
solves an entire class of problems, right?.  Could you explain a bit
what kinds of security issues it introduces?

-- Dave

