Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTEFGvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTEFGvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:51:10 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23315
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262400AbTEFGvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:51:09 -0400
Date: Tue, 6 May 2003 00:03:34 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Valdis.Kletnieks@vt.edu
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030506070334.GG8350@matchmail.com>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <mail.linux.kernel/20030420185512.763df745.skraw@ithnet.com> <03Apr21.020150edt.41463@gpu.utcc.utoronto.ca> <20030421131934.1f6e29b0.skraw@ithnet.com> <200304211414.h3LEEJtb002870@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304211414.h3LEEJtb002870@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 10:14:19AM -0400, Valdis.Kletnieks@vt.edu wrote:
> No amount of code wanking in the filesystem is going to save you if you hit
> an error on your swap partition - but an 'md'-like driver might be able to
> save you.

Unless you swap to a file... ;)

Which can be a overall benifet if you have one filesystem/partition on a
drive.  Your swap is closer to you data, and thus faster seek time. :)

Now let's watch all of the people mention all of the deadlocks that come
along with this...  (really, I'd like to know.)
