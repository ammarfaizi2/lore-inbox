Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVKIJ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVKIJ1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 04:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVKIJ07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 04:26:59 -0500
Received: from main.gmane.org ([80.91.229.2]:2251 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751351AbVKIJ06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 04:26:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dick <dm@chello.nl>
Subject: Re: SIGALRM ignored
Date: Wed, 9 Nov 2005 09:21:19 +0000 (UTC)
Message-ID: <loom.20051109T101742-953@post.gmane.org>
References: <loom.20051107T183059-826@post.gmane.org> <20051107160332.0efdf310.pj@sgi.com> <loom.20051108T124813-159@post.gmane.org> <87hdamk56f.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.58.57.243 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051003 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin <phil <at> fifi.org> writes:
> > Does someone know a debugging technique to see whats happening?
> Cat /proc/pid/status and look for the SigBlk line (blocked signals)
> and the SigIgn (ignored signals).  SIGALRM is 14, look for bit 14,
> that is 0000000000002000.  This bit should not be set.

And it is set (SigBlk: 0000000000012000) ... Thank you very much, I have to
search in another direction.

Greetings,
Dick

