Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUFOKK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUFOKK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 06:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUFOKKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 06:10:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:45482 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264668AbUFOKKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 06:10:22 -0400
Date: Tue, 15 Jun 2004 03:09:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: foo@porto.bmb.uga.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-Id: <20040615030932.3ff1be80.akpm@osdl.org>
In-Reply-To: <20040615062236.GA12818@porto.bmb.uga.edu>
References: <20040615062236.GA12818@porto.bmb.uga.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

foo@porto.bmb.uga.edu wrote:
>
> I'm getting processes hung in the D state accessing the mount point of
>  the home directories on my file server

Wait for it to happen again, then do

	echo t > /proc/sysrq-trigger
	dmesg -s 1000000 > foo

then send foo, foo.
