Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTJNRpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTJNRpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:45:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45980 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262652AbTJNRpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:45:02 -0400
Date: Tue, 14 Oct 2003 10:38:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: mochel@osdl.org, gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs -- don't crash if removing non-existant attribute
 group
Message-Id: <20031014103832.5997576c.davem@redhat.com>
In-Reply-To: <20031013162559.5ff55929.shemminger@osdl.org>
References: <20031003224931.57ac536a.davem@redhat.com>
	<20031013162559.5ff55929.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003 16:25:59 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> This fixes sysfs so it ignores the problem.  Another set of patches
> will address the remaining buggy ether drivers.

Please change this patch to add a net_ratelimit()'d warning message so
that we can catch new instances of this problem.

Thanks.

