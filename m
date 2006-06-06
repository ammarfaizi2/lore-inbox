Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWFFQQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWFFQQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWFFQQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:16:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751211AbWFFQQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:16:22 -0400
Date: Tue, 6 Jun 2006 09:15:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch, -rc5-mm3] lock validator: -V3
Message-Id: <20060606091515.27db4746.akpm@osdl.org>
In-Reply-To: <20060606154530.GA11063@elte.hu>
References: <20060606154530.GA11063@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 17:45:30 +0200
Ingo Molnar <mingo@elte.hu> wrote:

>  30 files changed, 545 insertions(+), 230 deletions(-)

This basically screws up the whole patch series.  It'll create a barrier
over which it will be hard to move fixups against existing patches.

ho-hum.  Let's make sure that future patches are extremely fine-grained and
please try to identify whether they're applicable to -v2 or to -v3 and we'll
see how it goes.
