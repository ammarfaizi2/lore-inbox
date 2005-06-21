Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVFULeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFULeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFULe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:34:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56230 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261244AbVFULb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:31:29 -0400
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
References: <208690000.1119330454@[10.10.2.4].suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2005 13:31:26 +0200
In-Reply-To: <208690000.1119330454@[10.10.2.4].suse.lists.linux.kernel>
Message-ID: <p733brcc5f5.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> writes:

> OK, after fixing the build failure with Andy's patch here:
> 
> http://mbligh.org/abat/apw_pci_assign_unassigned_resources
> 
> I get a boot failure on the NUMA-Q box. Full log is here:

FWIW i tried 2.6.12-rc6 (not final yet) on a 16 way x86-64 box
and it also always deadlocked early when trying to boot the
other CPUs (in fact when waiting for the migration thread
to process a request). 2.6.11 worked.

-Andi

