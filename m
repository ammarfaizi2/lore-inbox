Return-Path: <linux-kernel-owner+w=401wt.eu-S1161046AbXAHXA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbXAHXA2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbXAHXA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:00:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51354 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161046AbXAHXA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:00:27 -0500
Date: Mon, 8 Jan 2007 15:00:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/4] make initkmem_list3 non init data to fix modpost
 warning
Message-Id: <20070108150009.65798531.akpm@osdl.org>
In-Reply-To: <20070108081104.GD7889@in.ibm.com>
References: <20070108081104.GD7889@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 13:41:04 +0530
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> o Somebody who knows this code well needs to review and ack.

eh.  Moving stuff from __initdata into .data is always safe.  If it
fixes the warning, it's correct ;)

I'll scoot all four of these into 2.6.20, thanks.
