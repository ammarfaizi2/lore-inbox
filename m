Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSJQMEo>; Thu, 17 Oct 2002 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJQMD5>; Thu, 17 Oct 2002 08:03:57 -0400
Received: from stud3.tuwien.ac.at ([193.170.75.13]:5575 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S261514AbSJQL7c>; Thu, 17 Oct 2002 07:59:32 -0400
Date: Thu, 17 Oct 2002 14:05:26 +0200
From: Stefan Schwandter <swan@shockfrosted.org>
To: linux-kernel@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Posix capabilities
Message-ID: <20021017120526.GC6014@TK150122.tuwien.teleweb.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at> <20021017032619.GA11954@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017032619.GA11954@think.thunk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

> > I saw capabilities and acl patches for ext2/3 enter -mm. Is it possible
> > now to give an executable (that lives on an ext2/ext3 fs) the necessary
> > rights to use SCHED_FIFO without being setuid root? Could someone give
> > me some pointers for these topics (capabilities support in linux, acl)?

> The patchs which I've been working on do not support capabilities;
> just extended attributes. 

Ah, ok... I thought that things work like this: the capabilities support
already is in the kernel, and to give an app a particular capability,
one has to add a particalar extended attribute to the application
executable. So I'm wrong here it seems?


regards, Stefan
-- 
----> http://www.shockfrosted.org
