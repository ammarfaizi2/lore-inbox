Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTEDMq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 08:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTEDMq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 08:46:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56704 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263590AbTEDMq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 08:46:28 -0400
Date: Sun, 4 May 2003 13:58:45 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mikhail Kruk <meshko@cs.brandeis.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fcntl file locking and pthreads
Message-ID: <20030504125845.GA32087@mail.jlokier.co.uk>
References: <Pine.LNX.4.33.0305040206270.20509-100000@iole.cs.brandeis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0305040206270.20509-100000@iole.cs.brandeis.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Kruk wrote:
> on 2.4 kernels fcntl-based file locking does not work with 
> clone-based threads as expected (by me): two threads of the same process 
> can acquire exclusive lock on a file at the same time.
> flock()-based locks work as expected, i.e. only one thread can have an 
> exclusive lock at a time.

Is this true even when _not_ setting CLONE_FILES?

cheers,
-- Jamie
