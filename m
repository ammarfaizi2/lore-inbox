Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTK1HVx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 02:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTK1HVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 02:21:53 -0500
Received: from holomorphy.com ([199.26.172.102]:49346 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262051AbTK1HVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 02:21:52 -0500
Date: Thu, 27 Nov 2003 23:21:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031128072148.GY8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128041558.GW19856@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 08:15:58PM -0800, William Lee Irwin III wrote:
> This is a forward port of Hugh Dickins' patch to implement ABI-
> preserving large software PAGE_SIZE support, effectively "large VM
> blocksize". It's also been called "subpages". "pgcl" is an abbreviation
> for "page clustering", after the historical but different BSD notion.

Now also ported to 2.6.0-test11:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/pgcl-2.6.0-test11-1.gz

This also corrects some PAGE_SHIFT instances that crept into mm/mmap.c
while I wasn't looking and drops sym2 driver changes.


-- wli
