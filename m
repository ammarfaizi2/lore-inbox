Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUIDRWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUIDRWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIDRWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:22:41 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:14021 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264668AbUIDRWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:22:39 -0400
Date: Sat, 4 Sep 2004 19:22:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Cc: Jan Blunck <j.blunck@tu-harburg.de>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040904172223.GC9765@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904181220.B16644@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040904181220.B16644@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 September 2004 18:12:20 +0100, Christoph Hellwig wrote:
> 
> > o unionmount - you might remember Jan Blunck's fix to ext3
> 
> Could you give some context please?

Trivial example union mount:

Top layer:	<empty>
2nd layer:	foo

Writes to foo have to be done in the top layer, so foo has to be
copied up first.  And since that has to be done inside the kernel,
any possible implementation will be similar to my code.

For further details on unionmount, you should ask Jan directly.  But
for politeness' sake, please wait a month or two, so he can focus on
his university exams before getting into the flamewars. ;)

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
