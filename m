Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTHCJ0R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270319AbTHCJ0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:26:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:64720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270256AbTHCJ0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:26:16 -0400
Date: Sun, 3 Aug 2003 02:27:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Message-Id: <20030803022723.760f6451.akpm@osdl.org>
In-Reply-To: <009201c3599f$04ff05c0$322bde50@koticompaq>
References: <009201c3599f$04ff05c0$322bde50@koticompaq>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Heikki Tuuri" <Heikki.Tuuri@innodb.com> wrote:
>
> What to do? People who write drivers should run heavy, multithreaded file
>  i/o tests on their computer using some SQL database which calls fsync(). For
>  example, run the Perl '/sql-bench/innotest's all concurrently on MySQL. If
>  the problems are in drivers, that could help.

Well there's a problem.  We're kernel people, not database people.  I, for
one, would not have a clue how to set such a thing up.

If someone could prepare a simple-enough-for-kernel-people description of
how to get such a test up and running, then we might make some progress.

