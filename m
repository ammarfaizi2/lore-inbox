Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUIDR0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUIDR0b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUIDR0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:26:30 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:26630 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264881AbUIDR0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:26:02 -0400
Date: Sat, 4 Sep 2004 18:25:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jan Blunck <j.blunck@tu-harburg.de>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040904182556.A16774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jan Blunck <j.blunck@tu-harburg.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904181220.B16644@infradead.org> <20040904172223.GC9765@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040904172223.GC9765@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Sat, Sep 04, 2004 at 07:22:23PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 07:22:23PM +0200, Jörn Engel wrote:
> On Sat, 4 September 2004 18:12:20 +0100, Christoph Hellwig wrote:
> > 
> > > o unionmount - you might remember Jan Blunck's fix to ext3
> > 
> > Could you give some context please?
> 
> Trivial example union mount:
> 
> Top layer:	<empty>
> 2nd layer:	foo
> 
> Writes to foo have to be done in the top layer, so foo has to be
> copied up first.  And since that has to be done inside the kernel,
> any possible implementation will be similar to my code.
> 
> For further details on unionmount, you should ask Jan directly.  But
> for politeness' sake, please wait a month or two, so he can focus on
> his university exams before getting into the flamewars. ;)

Oh, I know what union mounts are.  But I wonder who's hacking on them
as they need some major VFS surgey to get right.

