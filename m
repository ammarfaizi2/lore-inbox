Return-Path: <linux-kernel-owner+w=401wt.eu-S932378AbXAIUMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbXAIUMY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 15:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbXAIUMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 15:12:24 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:59709 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376AbXAIUMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 15:12:23 -0500
Date: Tue, 9 Jan 2007 15:11:34 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Frank van Maarseveen <frankvm@frankvm.com>
cc: Miklos Szeredi <miklos@szeredi.hu>, pavel@ucw.cz,
       mikulas@artax.karlin.mff.cuni.cz, matthew@wil.cx, bhalevy@panasas.com,
       arjan@infradead.org, jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <20070109195310.GA10572@janus>
Message-ID: <Pine.LNX.4.58.0701091508090.10719@gandalf.stny.rr.com>
References: <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz>
 <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz>
 <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz>
 <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu> <20070108112916.GB25857@elf.ucw.cz>
 <E1H3tAe-00052Q-00@dorka.pomaz.szeredi.hu> <1168359985.7817.4.camel@localhost.localdomain>
 <20070109195310.GA10572@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2007, Frank van Maarseveen wrote:

>
> Yes but "cp -rl" is typically done by _developers_ and they tend to
> have a better understanding of this (uh, at least within linux context
> I hope so).
>
> Also, just adding hard-links doesn't increase the number of inodes.

No, but it increases the number of inodes that have link >1. :)
-- Steve

