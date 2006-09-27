Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965474AbWI0K05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965474AbWI0K05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965524AbWI0K05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 06:26:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:49813 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965474AbWI0K05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 06:26:57 -0400
From: Andi Kleen <ak@suse.de>
To: Andre Noll <maan@systemlinux.org>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
Date: Wed, 27 Sep 2006 12:26:44 +0200
User-Agent: KMail/1.9.3
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Andy Whitcroft <apw@shadowen.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ian Campbell <Ian.Campbell@xensource.com>
References: <45185A93.7020105@google.com> <m1venaqeg6.fsf@ebiederm.dsl.xmission.com> <20060927095839.GK20462@skl-net.de>
In-Reply-To: <20060927095839.GK20462@skl-net.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271226.44834.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 11:58, Andre Noll wrote:
> On 19:35, Eric W. Biederman wrote:
> > I have seen this one as well,
> 
> Me too. Current linus git tree, x86_64 SMP, gcc-3.3.5, GNU ld version 2.15, binutils
> 2.15-6, Debian.

We can probably revert the notes patch for now, since it is only needed
for Xen which isn't even merged yet.

Ian, do you think you can do the notes in some different way that still
works with old binutils?

-Andi
