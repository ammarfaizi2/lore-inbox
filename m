Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759778AbWLDE47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759778AbWLDE47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 23:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759796AbWLDE47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 23:56:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:29620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759771AbWLDE46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 23:56:58 -0500
Date: Sun, 3 Dec 2006 20:56:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: <Aucoin@Houston.RR.com>
Cc: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: Re: la la la la ... swappiness
Message-Id: <20061203205649.98df030b.akpm@osdl.org>
In-Reply-To: <200612032356.kB3NuPc0010673@ms-smtp-04.texas.rr.com>
References: <Pine.LNX.4.63.0612032137380.17489@gockel.physik3.uni-rostock.de>
	<200612032356.kB3NuPc0010673@ms-smtp-04.texas.rr.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006 17:56:30 -0600
"Aucoin" <Aucoin@Houston.RR.com> wrote:

> I hope I haven't muddied things up even more but basically what we want to
> do is find a way to limit the number of cached pages for disk I/O on the OS
> filesystem, even if it drastically slows down the untar and verify process
> because the disk I/O we really care about is not on any of the OS
> partitions.

Try mounting that fs with `-o sync'.
