Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWJPKPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWJPKPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWJPKPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:15:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:29887 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030348AbWJPKPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:15:20 -0400
From: Andi Kleen <ak@suse.de>
To: kmannth@us.ibm.com
Subject: Re: [Patch] x86_64 hot-add memroy srat.c fix
Date: Mon, 16 Oct 2006 12:01:16 +0200
User-Agent: KMail/1.9.3
Cc: andrew <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Konrad redhat <konradr@redhat.com>, dzickus@redhat.com,
       lhms-devel <lhms-devel@lists.sourceforge.net>
References: <1160175229.5663.23.camel@keithlap>
In-Reply-To: <1160175229.5663.23.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161201.16140.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 October 2006 00:53, keith mannthey wrote:
>   This patch corrects the logic used in srat.c to figure out what
> parsing what action to take when registering hot-add areas.  Hot-add
> areas should only be added to the node information for the
> MEMORY_HOTPLGU_RESERVE case.  When booting MEMORY_HOTPLUG_SPARSE hot-add
> areas on everything but the last node are getting include in the node
> data and during kernel boot the pages are setup then the kernel dies
> when the pages are used. This patch fixes this issue.  It is based
> against 2.6.19-rc1.  

Added thanks, especially since it's a obvious typo.

If that patch was added to .19 does sparsemem hotadd work then or does it
need more patches?

-Andi
