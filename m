Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTDFSTq (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTDFSTq (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 14:19:46 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:42759
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263050AbTDFSTp 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 14:19:45 -0400
Subject: Re: 2.5.65-preempt booting on 32way NUMAQ
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@aracnet.com>
In-Reply-To: <20030406112340.GM993@holomorphy.com>
References: <Pine.LNX.4.50.0304060625130.2268-100000@montezuma.mastecende.com>
	 <20030406112340.GM993@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049653846.753.156.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 06 Apr 2003 14:30:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 07:23, William Lee Irwin III wrote:

> Congratulations rml!

No, congratulations to Zwane :)

> If you're booting without issues on these things, you are a _very_ long
> way toward being race-free. This is incredibly good news, both for the
> preemption support, and for the general stability of the i386 bootstrap.

Indeed.  Successfully booting and running a 32-way SMP+preempt machine
is a very good test.

> All that's really left is driver and non-i386 arch coverage if I'm right.

If you know of something specific, please share.  I know the tty layer
needs work, but as far as I can tell, it is SMP issues that preemption
exposes... if any drivers in specific need work, let me know.

	Robert Love

