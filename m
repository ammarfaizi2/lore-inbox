Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWHBJYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWHBJYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 05:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWHBJYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 05:24:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:36771 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751201AbWHBJYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 05:24:35 -0400
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] Replace i386 open-coded cmdline parsing with early_param/parse_early_param
Date: Wed, 2 Aug 2006 11:24:22 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <0adfc39039c79e4f4121.1154462446@ezr> <200608020724.23583.ak@suse.de> <1154509680.10326.5.camel@localhost.localdomain>
In-Reply-To: <1154509680.10326.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608021124.22125.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 11:08, Rusty Russell wrote:
> This patch replaces the open-coded early commandline parsing
> throughout the i386 boot code with the generic mechanism (already used
> by ppc, powerpc, ia64 and s390).  The code was inconsistent with
> whether it deletes the option from the cmdline or not, meaning some of
> these will get passed through the environment into init.

Both merged now thanks.

-Andi
