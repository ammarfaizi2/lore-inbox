Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVI1SHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVI1SHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVI1SHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:07:21 -0400
Received: from tiere.net.avaya.com ([198.152.12.100]:54997 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP
	id S1750711AbVI1SHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:07:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Date: Wed, 28 Sep 2005 12:06:21 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC086F02D1@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Thread-Index: AcXENmLaJQWJgFi9RZGK1SCQam7eWwAIIxbQ
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I entirely understand what you're saying.  I feel like you're not
> reading my responses.  GDB _already has a list of signals it does not
> care about_.  If ptrace permitted, it could tell the kernel not to
> context switch to deliver those signals.  In advance!  That's a
> debugger-driven solution to your problem.
> 
> I'm not arguing out of theory here.  I've implemented this mechanism
> before in other contexts, for instance to prevent the remote protocol
> overhead for ignored signals when using gdb with gdbserver.
> 


Okay, I'll come up with an alternative patch that enhances the ptrace
interface so the debugger can guide the kernel to NOT context switch and
bother it about signal x from task y.

Would you be amenable to such a patch?

Thanks

- Bhavesh
