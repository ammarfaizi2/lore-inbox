Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271186AbTG1XEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271187AbTG1XEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:04:09 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:38567
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271186AbTG1XDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:03:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: as / scheduler question
Date: Tue, 29 Jul 2003 09:08:09 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307290908.09065.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick

With the sheduler work Ingo and I have been doing I was wondering if there was 
possibly a problem with requeuing kernel threads at certain intervals? Ingo's 
current version requeues all threads at 25ms and I just wondered if this 
number might be a multiple or factor of a magic number in the AS workings, as 
we're seeing a few changes in behaviour with AS only. I'm planning on leaving 
kernel threads out of this requeuing, but I thought I could also pick your 
brain.

Con

