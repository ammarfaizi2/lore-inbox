Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTITHtm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 03:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbTITHtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 03:49:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24506 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261624AbTITHtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 03:49:41 -0400
Date: Sat, 20 Sep 2003 00:37:19 -0700
From: "David S. Miller" <davem@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 9/13] use cpu_relax() in busy loop
Message-Id: <20030920003719.29e85422.davem@redhat.com>
In-Reply-To: <20030918163757.M16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net>
	<20030918162748.F16499@osdlab.pdx.osdl.net>
	<20030918162930.G16499@osdlab.pdx.osdl.net>
	<20030918163156.H16499@osdlab.pdx.osdl.net>
	<20030918163311.I16499@osdlab.pdx.osdl.net>
	<20030918163408.J16499@osdlab.pdx.osdl.net>
	<20030918163523.K16499@osdlab.pdx.osdl.net>
	<20030918163645.L16499@osdlab.pdx.osdl.net>
	<20030918163757.M16499@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003 16:37:57 -0700
Chris Wright <chrisw@osdl.org> wrote:

> Replace busy loop nop with cpu_relax().

Applied, thanks Chris.
