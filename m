Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWDYJAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWDYJAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWDYJAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:00:46 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:45547 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932149AbWDYJAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:00:45 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "=?ISO-8859-1?Q?J=F6rn?= Engel" <joern@wohnheim.fh-wedel.de>
Cc: Michael Holzheu <holzheu@de.ibm.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
In-Reply-To: <20060425085230.GA23127@wohnheim.fh-wedel.de>
References: <20060424191941.7aa6412a.holzheu@de.ibm.com>
	 <1145948304.11463.5.camel@localhost> <1145950336.11463.8.camel@localhost>
	 <20060425085230.GA23127@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 25 Apr 2006 12:00:42 +0300
Message-Id: <1145955643.27659.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 April 2006 10:32:16 +0300, Pekka Enberg wrote:
> > Hmm, thinking about this, I think a better API would be to not have that
> > reject parameter at all. Would something like this be accetable for your
> > use?

On Tue, 2006-04-25 at 10:52 +0200, Jörn Engel wrote:
> [...]
> 
> > +	while (*s && isspace(*s))
> > +		s++;
> 
> Just checking.  This does remove a newline, right?

Yes, it does.

				Pekka

