Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWI0MFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWI0MFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWI0MFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:05:17 -0400
Received: from ns1.suse.de ([195.135.220.2]:57251 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030204AbWI0MFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:05:15 -0400
From: Andi Kleen <ak@suse.de>
To: Ian Campbell <Ian.Campbell@xensource.com>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
Date: Wed, 27 Sep 2006 14:05:03 +0200
User-Agent: KMail/1.9.3
Cc: Andre Noll <maan@systemlinux.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Andy Whitcroft <apw@shadowen.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <45185A93.7020105@google.com> <200609271226.44834.ak@suse.de> <1159355329.28313.29.camel@localhost.localdomain>
In-Reply-To: <1159355329.28313.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271405.03849.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The xen-unstable tree has had the .bss movement patch in for a couple of
> weeks now with no reported bugs. We are frozen for the release 3.0.3 so
> at least in theory people should be testing it pretty hard ;-)

Ok maybe we should retry it. The BSS movement patch makes sense by
itself after all and in theory really shouldn't break anything.
I'll reenable it.

-Andi
