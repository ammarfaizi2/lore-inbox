Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWAZS0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWAZS0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWAZS0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:26:43 -0500
Received: from mx.pathscale.com ([64.160.42.68]:12776 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932242AbWAZS0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:26:42 -0500
Subject: Re: [Perfctr-devel] RE: [perfmon] Re: quick overview of the
	perfmon2 interface
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: eranian@hpl.hp.com
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, perfmon@napali.hpl.hp.com,
       "Eranian, Stephane" <stephane.eranian@hp.com>,
       Andrew Morton <akpm@osdl.org>, "Truong, Dan" <dan.truong@hp.com>
In-Reply-To: <20060126074850.GA11138@frankl.hpl.hp.com>
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net>
	 <1138221212.15295.35.camel@serpentine.pathscale.com>
	 <20060125222844.GB10451@frankl.hpl.hp.com>
	 <1138229203.15295.65.camel@serpentine.pathscale.com>
	 <20060126074850.GA11138@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 10:26:42 -0800
Message-Id: <1138300002.12632.51.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 23:48 -0800, Stephane Eranian wrote:

> You need to be root to insert the module. But I believe that for many user
> environments, this is more practical than having to recompile a custom kernel.

Clearly.

> You can imagine the format being shipped with the tool, when the sysadmin
> installs the tool it also installs the module.

In that case, you need some kind of per-distro cruft to make sure the
module gets loaded at every boot, or a setuid program that can install
the module, right?.  Neither of these approaches works well in a cluster
environment where you're running your tools from a shared directory.

I'd really like the default mode of operation for users to not require
root privileges to get at normal functionality.  This is something
perfctr makes possible, for example.

	<b

