Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUHaWGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUHaWGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269171AbUHaWBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:01:30 -0400
Received: from peabody.ximian.com ([130.57.169.10]:5310 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269141AbUHaWAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:00:36 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040831150015.2e0e0906.akpm@osdl.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831150015.2e0e0906.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 Aug 2004 18:00:01 -0400
Message-Id: <1093989601.4815.48.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 15:00 -0700, Andrew Morton wrote:

> Why not share the implementation here?

Because we will probably want to export do_send_kevent(), with a
different name, if this thing starts getting used, because there are
places where the kobj path is already computed and although inexpensive
it does cost a few cycles to go kobject -> path as a string.

	Robert Love


