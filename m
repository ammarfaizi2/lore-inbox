Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWBHVBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWBHVBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBHVBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:01:33 -0500
Received: from cantor.suse.de ([195.135.220.2]:62153 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751142AbWBHVBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:01:32 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation
Date: Wed, 8 Feb 2006 22:01:11 +0100
User-Agent: KMail/1.8.2
Cc: Christoph Lameter <clameter@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com> <Pine.LNX.4.62.0602081228260.4335@schroedinger.engr.sgi.com> <20060208125521.b9a2aa5e.pj@sgi.com>
In-Reply-To: <20060208125521.b9a2aa5e.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602082201.12371.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 21:55, Paul Jackson wrote:

> If that argument justifies OOM killing on a simple UMA system, then
> surely, for -some- critical tasks, it justifies it on a big NUMA system.
> 
> Either OOM is useful in some cases or it is not.


I don't think you really want to open a  full scale "is the oom killer needed"
thread. Check the archives - there have been some going on for months.

But I think we can agree that together with mbind the oom killer is pretty
useless, can't we?


-Andi (who is definitely in favour of Christoph's latest patch) 
