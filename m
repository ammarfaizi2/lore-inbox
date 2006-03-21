Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWCUMlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWCUMlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWCUMlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:41:19 -0500
Received: from thunk.org ([69.25.196.29]:41697 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751598AbWCUMlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:41:18 -0500
Date: Tue, 21 Mar 2006 07:40:58 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@davemloft.net,
       linux-kernel@vger.kernel.org, prasanna@in.ibm.com, suparna@in.ibm.com
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-ID: <20060321124058.GF8257@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@davemloft.net,
	linux-kernel@vger.kernel.org, prasanna@in.ibm.com,
	suparna@in.ibm.com
References: <20060320181255.16932b0d.akpm@osdl.org> <OFB22908E4.CE9C1F2E-ON80257138.0030CAF3-80257138.0032BABE@uk.ibm.com> <20060321111452.GA5460@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321111452.GA5460@infradead.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 11:14:52AM +0000, Christoph Hellwig wrote:
> > A real life example of where this capability would have been very useful is
> > with a performance problem I am currently investigating. It involves a GPFS
> > + SAMBA + TCPIP +  RDAC
> 
> this pobablt tells more about the crappy code quality of your propritary
> code than a real need for this.   please argue without reference to huge
> blobs of junk.

In real life there are complicated stacks; sometimes they are open
source (for example, like JBoss or Tomcat), sometimes they are
propietary products, sometimes they are custom applications written by
the end-user.  Sun has been making big hay about how with dtrace, you
can easily figure out what is going on.  Systemtap is a tool that will
allow us to have have this kind of capability, and user space probes
is part of that project.  

						- Ted
