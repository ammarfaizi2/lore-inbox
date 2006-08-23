Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWHWIu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWHWIu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWHWIu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:50:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:7882 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964779AbWHWIu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:50:26 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 10:50:13 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <1156319788.2829.12.camel@laptopd505.fenrus.org> <44EC1563.90206@vmware.com>
In-Reply-To: <44EC1563.90206@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231050.13272.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, after discussion with Rusty, it appears that beefing up 
> stop_machine_run is the right way to go.  And it has benefits for 
> non-paravirt code as well, such as allowing plug-in kprobes or oprofile 
> extension modules to be loaded without having to deal with a debug 
> exception or NMI during module load/unload.

I'm still unclear where you think those debug exceptions will come from?

-Andi
