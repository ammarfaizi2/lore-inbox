Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVHXVVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVHXVVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVHXVVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:21:55 -0400
Received: from ns2.suse.de ([195.135.220.15]:45017 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932250AbVHXVVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:21:54 -0400
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Memory problem w/ recent kernels on 2x Opteron with 12 GB RAM
Date: Wed, 24 Aug 2005 23:21:48 +0200
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, discuss@x86-64.org
References: <200508242308.55433.rjw@sisk.pl>
In-Reply-To: <200508242308.55433.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242321.48367.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 August 2005 23:08, Rafael J. Wysocki wrote:
> Hi,
>
> I'm currently seeing a memory problem on a NUMA-enabled dual-Opteron 250
> box with the 2.6.12.5 and 2.6.13-rc* (up to 7) kernels.  Namely, the box
> has 12 GB of RAM, 8 GB of which is installed on the first node.  The whole
> memory is detected but then only the first 8 GB of it is made available
> (minus some hardware-related holes), as though the memory on the second
> node were discarded for some reason.


Boot log please?

-Andi
