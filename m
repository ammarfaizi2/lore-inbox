Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUITPqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUITPqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUITPqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:46:30 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:49575 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266749AbUITPqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:46:14 -0400
Date: Mon, 20 Sep 2004 08:45:29 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [4/7] universally available
 cmpxchg on i386
In-Reply-To: <200409191430.37444.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0409200844460.3633@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409181627300.24054@schroedinger.engr.sgi.com>
 <200409191430.37444.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, Denis Vlasenko wrote:

> Far too large for inline
> Ditto.

Umm... The code was inline before and for non 80386 its the same size as
before.

