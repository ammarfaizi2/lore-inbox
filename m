Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTJJJxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbTJJJxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:53:13 -0400
Received: from holomorphy.com ([66.224.33.161]:11137 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262767AbTJJJxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:53:13 -0400
Date: Fri, 10 Oct 2003 02:56:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.6.0-test7
Message-ID: <20031010095612.GD700@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lorenzo Allegrucci <l.allegrucci@tiscali.it>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200310101141.03064.l.allegrucci@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310101141.03064.l.allegrucci@tiscali.it>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 11:41:03AM +0000, Lorenzo Allegrucci wrote:
> Multiple oops, machine is a Athlon uniprocessor.
> 100% reproducible.  Need more info? My .config?
> (sorry >80 cols)

Please try reverting:

ChangeSet 1.1353, 2003/09/21 12:16:28-07:00, albert@users.sourceforge.net
        [PATCH] fix for hidden-task problem

until we figure out what's going wrong.

Thanks.

-- wli
