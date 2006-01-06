Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752155AbWAFSHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbWAFSHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWAFSHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:07:14 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:13696 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751586AbWAFSHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:07:11 -0500
Date: Fri, 6 Jan 2006 11:07:11 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Arjan van de Ven <arjan@infradead.org>,
       hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>, John Hesterberg <jh@sgi.com>,
       Greg Edwards <edwardsg@sgi.com>
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
Message-ID: <20060106180711.GG19769@parisc-linux.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com> <20060106174957.GF19769@parisc-linux.org> <Pine.LNX.4.62.0601060958110.17665@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601060958110.17665@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:04:56AM -0800, Christoph Lameter wrote:
> On Fri, 6 Jan 2006, Matthew Wilcox wrote:
> > You can use that argument to set the CPU limit low too -- since a kernel
> > with a CPU limit lower than the number of CPUs in the box will just ignore
> > the additional ones, people who want to get the additional performance
> > will tune limits that are set lower than they need ;-)
> 
> The dicey thing in all of this is that the generic kernels will be used 
> for the certification of applications. If the cpu limit is too low then 

Why on earth would somebody do that?
