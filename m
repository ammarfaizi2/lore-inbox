Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbTIUHFb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 03:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbTIUHFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 03:05:31 -0400
Received: from verein.lst.de ([212.34.189.10]:64139 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261778AbTIUHF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 03:05:28 -0400
Date: Sun, 21 Sep 2003 09:05:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move some more intilization out of drivers/char/mem.c
Message-ID: <20030921070524.GA1992@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030920132900.GC23153@lst.de> <20030920160645.30c2745d.akpm@osdl.org> <20030921063030.GA1508@lst.de> <20030920234853.7e09f663.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030920234853.7e09f663.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 11:48:53PM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> >
> > > Please compile-test things...
> > 
> >  Well, I compiled this here.  I see, looks like I lost half of the patch
> >  when sending it to you.  Sorryh for that, here's the full patch:
> 
> It still generates warnings.  I suggest you build kernels with a script
> which saves up stderr and spits it all out at the end.  That way, these
> things are noticed.

Well, I do that, but they slipped through anyway.  I did a completle
rebuild now and saw them.  I really need a filter for all those anoying
warnings from the debian sid assembler..
