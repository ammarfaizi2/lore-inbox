Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVHAX74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVHAX74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVHAX74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:59:56 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:16577 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261273AbVHAX7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:59:54 -0400
Date: Mon, 1 Aug 2005 16:59:47 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050801165947.36b5da96.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0508011618120.9351@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
	<20050729152049.4b172d78.pj@sgi.com>
	<Pine.LNX.4.62.0507291746000.8663@graphe.net>
	<20050729230026.1aa27e14.pj@sgi.com>
	<Pine.LNX.4.62.0507301042420.26355@graphe.net>
	<20050730181418.65caed1f.pj@sgi.com>
	<Pine.LNX.4.62.0507301814540.31359@graphe.net>
	<20050730190126.6bec9186.pj@sgi.com>
	<Pine.LNX.4.62.0507301904420.31882@graphe.net>
	<20050730191228.15b71533.pj@sgi.com>
	<Pine.LNX.4.62.0508011147030.5541@graphe.net>
	<20050801160351.71ee630a.pj@sgi.com>
	<Pine.LNX.4.62.0508011618120.9351@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> you need to create multiple 
> levels of directories in /proc/<pid>/xx

You do?

Where's the new multiple directory levels in the two files:

	/proc/<pid>/numa_policy		# contains one word
	/proc/<pid>/numa_nodelist	# contains one nodelist

There are some obvious negatives to this idea, but having to
"create multiple levels of directories" doesn't seem to be
one of them.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
