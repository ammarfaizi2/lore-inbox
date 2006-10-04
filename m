Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161905AbWJDSAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161905AbWJDSAE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161546AbWJDR71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:59:27 -0400
Received: from mail.suse.de ([195.135.220.2]:59274 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161239AbWJDR7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:59:19 -0400
To: David Chinner <dgc@sgi.com>
Cc: xfs-dev@sgi.com, xfs@oss.sgi.com, dhowells@redhat.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/3] Convert XFS inode hashes to radix trees
References: <20061003060610.GV3024@melbourne.sgi.com>
	<20061003212335.GA13120@tuatara.stupidest.org>
	<20061003222256.GW4695059__33273.3314754025$1159914338$gmane$org@melbourne.sgi.com>
From: Andi Kleen <ak@suse.de>
Date: 04 Oct 2006 19:59:15 +0200
In-Reply-To: <20061003222256.GW4695059__33273.3314754025$1159914338$gmane$org@melbourne.sgi.com>
Message-ID: <p73y7rwynbg.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> writes:
> 
> And yes, 64 bit systems are cheap, cheap, cheap so IMO this
> functionality is really irrelevant moving forward. If it had come
> along a couple of years ago then it would be different, but I think
> mainstream technology is finally catching up with XFS so it's not a
> critical issue anymore... ;)

One issue is that people often still run a lot of 32bit userland
even with 64bit kernels. The compat layer will just truncate
the inodes I think. But so far I haven't heard of anybody
complaining on x86-64.

-Andi
