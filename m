Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWBTSH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWBTSH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWBTSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:07:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:26578 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932615AbWBTSHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:07:55 -0500
Subject: Re: (pspace,pid) vs true pid virtualization
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
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
In-Reply-To: <43F9882C.3060501@sw.ru>
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	 <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>  <43F9882C.3060501@sw.ru>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 10:07:49 -0800
Message-Id: <1140458869.10909.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 12:13 +0300, Kirill Korotaev wrote:
> > - Should a process have some sort of global (on the machine identifier)?
> yep. otherwise it is imposible to manage (ptrace, kill, ...) it, without 
> introducing new syscalls. 

Why is introducing syscalls so bad?  Does anybody have a list of exactly
how many we would need if we added some kind of container argument?

-- Dave

