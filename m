Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTEXW0d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 18:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTEXW0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 18:26:33 -0400
Received: from ns.suse.de ([213.95.15.193]:12305 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261216AbTEXW0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 18:26:32 -0400
Date: Sun, 25 May 2003 00:39:40 +0200
From: Andi Kleen <ak@suse.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Andi Kleen <ak@suse.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ACPI compile again on 64bit/gcc 3.3 II
Message-ID: <20030524223940.GB22506@wotan.suse.de>
References: <F760B14C9561B941B89469F59BA3A847E96ED2@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96ED2@orsmsx401.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 01:55:26PM -0700, Grover, Andrew wrote:
> Actually, I think osl.c should be changed to match the header as it
> stands. Could you try that and see if that also fixes things?

On looking again these functions are not used at all.
How about just removing them? 

If you really wanted them you could implement them really by walking
page tables on i386.

-Andi
