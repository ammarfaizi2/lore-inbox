Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbTC3BkZ>; Sat, 29 Mar 2003 20:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263233AbTC3BkZ>; Sat, 29 Mar 2003 20:40:25 -0500
Received: from cs.columbia.edu ([128.59.16.20]:59815 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S263003AbTC3BkZ>;
	Sat, 29 Mar 2003 20:40:25 -0500
Subject: Re: process creation/deletions hooks
From: Shaya Potter <spotter@yucs.org>
To: Chris Wright <chris@wirex.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030328180303.A26128@figure1.int.wirex.com>
References: <1048799290.31010.62.camel@zaphod>
	 <20030328180303.A26128@figure1.int.wirex.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048989040.32227.126.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Mar 2003 20:50:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

would that be task_alloc_security() and task_free_security()?

On Fri, 2003-03-28 at 21:03, Chris Wright wrote:
> * Shaya Potter (spotter@yucs.org) wrote:
> > 
> > Would people be for/against an interface that allows for modules to
> > register functions that can be called on process creation/deletion.  It
> > would help us avoid the hacks, such as I described, and I imagine could
> > have benefit others.
> 
> LSM provides hooks here already.  Take a look at lsm.immunix.org for
> more info.
> 
> thanks,
> -chris

