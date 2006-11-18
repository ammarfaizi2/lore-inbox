Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756194AbWKRIta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194AbWKRIta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 03:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbWKRIta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 03:49:30 -0500
Received: from ns1.suse.de ([195.135.220.2]:47290 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1756194AbWKRIt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 03:49:29 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH 2/20] x86_64: Assembly safe page.h and pgtable.h
Date: Sat, 18 Nov 2006 09:49:14 +0100
User-Agent: KMail/1.9.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
References: <20061117223432.GA15449@in.ibm.com> <20061117223721.GC15449@in.ibm.com>
In-Reply-To: <20061117223721.GC15449@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611180949.15243.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 23:37, Vivek Goyal wrote:
> 
> This patch makes pgtable.h and page.h safe to include
> in assembly files like head.S.  Allowing us to use
> symbolic constants instead of hard coded numbers when
> refering to the page tables.

I still think that macro is horrible ugly and the use of that
macro should be minimized as suggested earlier.

-Andi
