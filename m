Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWJKSy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWJKSy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWJKSy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:54:58 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:28512 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751272AbWJKSy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:54:57 -0400
Message-ID: <452D3DFA.6010408@tls.msk.ru>
Date: Wed, 11 Oct 2006 22:54:50 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [SOT] GIT usage question
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For quite some time I'm trying to understand if it's possible
to extract changes from some subsystem's GIT tree compared to
some version of linux kernel.

For example, let's say I want to see if my SATA controller will
work with current libata, but without all the pain of trying
current 2.6.19-pre/rc instabilities.  Libata changes are quite
local for the subsystem, so in theory, or at least how I see
it, that should be possible.

So I have 3 remote branches in my local GIT tree:

 o origin which points to Linus's 2.6.19-pre
 o libata, which is current libata tree
 o 2.6.18 release -- the kernel I'm running right now.

I want to get changes *for libata subsystem* in origin or
libata (libata is just changes which are on the way to Linus,
and current difference is very minor), to apply against 2.6.18.
Ie, in short, changes which went to origin *from* libata.

Is it possible?

Thanks.

/mjt
