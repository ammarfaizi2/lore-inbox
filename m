Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbTIQEng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 00:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTIQEng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 00:43:36 -0400
Received: from rth.ninka.net ([216.101.162.244]:42900 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262560AbTIQEng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 00:43:36 -0400
Date: Tue, 16 Sep 2003 21:43:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Raf D'Halleweyn" <raf@noduck.net>
Cc: vishwas@eternal-systems.com, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum
Message-Id: <20030916214333.6e2bfd8e.davem@redhat.com>
In-Reply-To: <1063769305.2801.1.camel@bigboy>
References: <3F3C07E2.3000305@eternal-systems.com>
	<20030821134924.GJ7611@naboo>
	<3F675B68.8000109@eternal-systems.com>
	<200309161900.h8GJ0kYe019776@turing-police.cc.vt.edu>
	<3F67734A.8060804@eternal-systems.com>
	<1063769305.2801.1.camel@bigboy>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 23:28:26 -0400
"Raf D'Halleweyn" <raf@noduck.net> wrote:

> This is what I wrote some time ago. But I haven't used it recently.

See include/net/ip.h:ip_increase_ttl().  Most people get this
code wrong, in particular the final carry.
