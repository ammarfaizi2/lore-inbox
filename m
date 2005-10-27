Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVJ0IcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVJ0IcX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbVJ0IcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:32:23 -0400
Received: from ns1.suse.de ([195.135.220.2]:38045 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964992AbVJ0IcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:32:22 -0400
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [discuss] [rfc] x86_64: Kconfig changes for NUMA
Date: Thu, 27 Oct 2005 10:31:15 +0200
User-Agent: KMail/1.8
Cc: discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
References: <20051026070956.GA3561@localhost.localdomain> <200510270950.13268.ak@suse.de> <aec7e5c30510270125q1e175daeoeaea99584f305261@mail.gmail.com>
In-Reply-To: <aec7e5c30510270125q1e175daeoeaea99584f305261@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510271031.15403.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 October 2005 10:25, Magnus Damm wrote:
>
> But if the same logic is applied to the NUMA code, why then is there
> both k8topology.c and srat.c? Does non-ACPI systems exist in x86_64
> land?

Historical reasons. The first AMD NUMA systems indeed didn't have SRAT
and before ACPI 3.0 was released there were some concerns about the
Microsoft license of SRAT. So k8topology was implemented as a stopgap.
The long term plan is to get rid of it though once the ACPI code has been
proven completely stable. 

-Andi
