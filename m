Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbUKQB2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbUKQB2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 20:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUKQB2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 20:28:46 -0500
Received: from almesberger.net ([63.105.73.238]:32264 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262152AbUKQB2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:28:45 -0500
Date: Tue, 16 Nov 2004 22:28:35 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Generalize prio_tree, 2nd try
Message-ID: <20041116222835.A9017@almesberger.net>
References: <Pine.GSO.4.58.0411151814440.6691@lazuli.engin.umich.edu> <20041116205135.Y28802@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116205135.Y28802@almesberger.net>; from werner@almesberger.net on Tue, Nov 16, 2004 at 08:51:35PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> +static void get_index(struct prio_tree_root *root, struct prio_tree_node *node,

They should of course be "const" ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
