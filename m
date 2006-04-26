Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWDZOTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWDZOTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWDZOTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:19:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:47593 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964784AbWDZOTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:19:36 -0400
To: "Jan Beulich" <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: apic= command line option should always be	honored
References: <444F9755.76E4.0078.0@novell.com>
From: Andi Kleen <ak@suse.de>
Date: 26 Apr 2006 16:19:34 +0200
In-Reply-To: <444F9755.76E4.0078.0@novell.com>
Message-ID: <p737j5c8lmx.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <jbeulich@novell.com> writes:

> When using apic= on the kernel command line, this had no effect for machines
> matched by either the ACPI MADT or the MPS OEM table scan. However, when such
> option is specified, it should also take effect for this set of systems.

Agreed yes. 

I will put it into my tree for now because I already have some related patches.

-Andi

