Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTIIJ7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 05:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTIIJ7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 05:59:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:6800 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263880AbTIIJ7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 05:59:35 -0400
Date: Tue, 9 Sep 2003 10:59:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with remap_page_range
Message-ID: <20030909095926.GA31080@mail.jlokier.co.uk>
References: <3F5E7ACD.8040106@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5E7ACD.8040106@tait.co.nz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmytro Bablinyuk wrote:
>  if (remap_page_range(vma->vm_start,

Try io_remap_page_range() instead?

-- Jamie
