Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWFZS6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWFZS6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbWFZS6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:58:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:61160 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S932661AbWFZS6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:58:49 -0400
X-Auth-Info: tFwMGI0xgR3E1/+unVI0R7RTsWoX6eJKiSTEvzpyv10=
Date: Mon, 26 Jun 2006 20:59:33 +0200
From: Christian Lohmaier <cloph@openoffice.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read  atip wiith cdrecord
Message-ID: <20060626185933.GA21692@bm617259.muenchen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624144739.78bde590.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 23:50:07 +0200, Andrew Morton wrote:
> On Sat, 24 Jun 2006 13:36:28 -0700
> bugme-daemon@bugzilla.kernel.org wrote:
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=6745
>> [...] 
> We seem to have an awful lot of these "CD burner doesn't work but it
> did in
> 2.4" reports.
> 
> Does anyone have the vaguest inklink of how we broke it?

I updated the bug-report with some info I collected from another bug.

Apparently my drive sends additional interrupts that confuses the kernel
and make it hang.
The problem is triggered with newer versions of cdrecord (cdrtools
2.01a33 and newer) where cdrecord changed its driver interface.

So it is only the combination that makes the bug appear.

I hope that with that information it will be possible to fix the kernel
so that it doesn't hang. 

ciao
Christian
-- 
NP: Pantera - Strength Beyond Strength
