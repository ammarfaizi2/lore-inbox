Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUG1SXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUG1SXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUG1SXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:23:07 -0400
Received: from main.gmane.org ([80.91.224.249]:36009 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261638AbUG1SXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:23:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: Re: clearing filesystem cache for I/O benchmarks
Date: Wed, 28 Jul 2004 14:19:09 -0400
Message-ID: <87llh4atb6.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org>
 <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org>
 <4106013E.30408@namesys.com> <87vfg9nyqv.fsf@osu.edu>
 <410698FA.40400@namesys.com> <87k6wocnmk.fsf@osu.edu>
 <4107DC4C.3040603@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp065-025-157-254.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:EdQ9SWRn3n5q6P+LOrvWFHw4QXI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> Probably the best you can do is write enough in the course of the test
> that fsync at the end (or data remaining in cache) is insignificant
> noise.  Benchmarks that make fsync or the cache significant
> unintentionally are common and bad.

I assure you, our benchmarks will avoid these common pitfalls.
-- 
Benjamin Rutt

