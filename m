Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWEJVwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWEJVwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWEJVwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:52:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:12417 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751510AbWEJVwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:52:53 -0400
From: Andi Kleen <ak@suse.de>
To: Brice Goglin <brice@myri.com>
Subject: Re: [PATCH 2/6] myri10ge - Add missing PCI IDs
Date: Wed, 10 May 2006 23:52:48 +0200
User-Agent: KMail/1.9.1
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
References: <446259A0.8050504@myri.com> <44625C92.8020209@myri.com>
In-Reply-To: <44625C92.8020209@myri.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605102352.48453.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 23:35, Brice Goglin wrote:
> [PATCH 2/6] myri10ge - Add missing PCI IDs
> 
> Add nVidia nForce CK804 PCI-E bridge and 
> ServerWorks HT2000 PCI-E bridge IDs.
> They will be used by the myri10ge driver.

That's a bad sign. It means you have code in your driver 
that should be somewhere else.

-Andi
