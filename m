Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTJTV7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTJTV7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:59:46 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:19976
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262813AbTJTV7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:59:44 -0400
Subject: Re: preempt patches and such for amd64?
From: Robert Love <rml@tech9.net>
To: markh@compro.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F943A6D.5863749A@compro.net>
References: <3F943A6D.5863749A@compro.net>
Content-Type: text/plain
Message-Id: <1066687188.21731.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Mon, 20 Oct 2003 17:59:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-20 at 15:41, Mark Hounschell wrote:

> Are the preempt, low latency, and cpu affinity patches applicable to the amd-64
> platform running in native 64 bit mode? I would also like to know the same about
> the O(1) scheduler patches. If not, will/does the 2.6 kernel implement these for
> amd-64?

The CPU affinity system call, the preemptive kernel, and the O(1)
scheduler are all available for x86-64 on 2.6.

I don't think any of the patches have been ported to 2.4, although the
CPU affinity system call would be trivial to get working.

	Robert Love


