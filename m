Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbVJZOpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbVJZOpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 10:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbVJZOph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 10:45:37 -0400
Received: from mx1.suse.de ([195.135.220.2]:26024 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751499AbVJZOph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 10:45:37 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [rfc] x86_64: Kconfig changes for NUMA
Date: Wed, 26 Oct 2005 16:46:25 +0200
User-Agent: KMail/1.8.2
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
References: <20051026070956.GA3561@localhost.localdomain>
In-Reply-To: <20051026070956.GA3561@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261646.26331.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 09:09, Ravikiran G Thirumalai wrote:

> 
> 1. Makes NUMA a config option like other arches
> 2. Makes topology detection options like K8_NUMA dependent on NUMA
> 3. Choosing ACPI NUMA detection can be done from the standard 
>    "Processor type and features" menu 
> Comments?

It's in principle ok except that I don't like the dependencies and
defaults. K8_NUMA shouldn't be dependent on !M_PSC. And the defaults
should be just dropped.

-Andi
