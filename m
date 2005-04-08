Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVDHRyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVDHRyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVDHRy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:54:29 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40590 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262903AbVDHRxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:53:36 -0400
Subject: Re: [PATCH] restrict inter_module_* to its last users
From: Josh Boyer <jdub@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050408104826.3ca70fb4.akpm@osdl.org>
References: <20050408170805.GE2292@wohnheim.fh-wedel.de>
	 <20050408104826.3ca70fb4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 08 Apr 2005 12:53:33 -0500
Message-Id: <1112982813.7573.1.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 10:48 -0700, Andrew Morton wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> > Next step for inter_module removal.  This patch makes the code
> >  conditional on its last users and shrinks the kernel binary for the
> >  huge majority of people.
> 
> If we do this, nobody will get around to fixing up the remaining users.

Well, here's a good starting point to actually fix things:

http://www.kernel.org/pub/linux/kernel/people/rusty/Module/remove-inter-module-mtd.patch.bz2

josh

