Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWB0Pma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWB0Pma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWB0Pma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:42:30 -0500
Received: from ns1.suse.de ([195.135.220.2]:45479 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964783AbWB0Pm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:42:29 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [Patch 0/4] Reordering of functions, try 2
Date: Mon, 27 Feb 2006 16:36:25 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
References: <1141053825.2992.125.camel@laptopd505.fenrus.org>
In-Reply-To: <1141053825.2992.125.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271636.26064.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 16:23, Arjan van de Ven wrote:

> 
> 2) In the "processor/processes" group, 7 tests changed behavior, and the
> average of these changes was a performance increase by 10% (!!). The
> exception was the signal handling test, which decreased by 6%. This
> actually made me feel good, since the original function list was based
> on a profile run that didn't do signals much if at all.

How often did you rerun lmbench each time? In my experience the numbers
are somewhat unstable. Still looks encouraging.

-Andi
