Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269092AbUJQJwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269092AbUJQJwg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 05:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUJQJwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 05:52:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14226 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269092AbUJQJwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 05:52:32 -0400
Date: Sun, 17 Oct 2004 11:53:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] exec-shield-nx-2.6.9-A1
Message-ID: <20041017095343.GA7976@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've released the latest exec-shield patch:

   http://redhat.com/~mingo/exec-shield/exec-shield-nx-2.6.9-A1

this is a merge of the exec-shield patches used in FC2/FC3 to mainline.
(The patch is smaller than earlier exec-shield patches or the 2.4 patch
because a sub-functionality related to exec-shield (flexmmap) got merged
to 2.6.9.)

This version of exec-shield makes use of NX too, if available (and PAE),
and falls back to the segment-limit method on CPUs that have no NX.

	Ingo
