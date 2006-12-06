Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936474AbWLFQmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936474AbWLFQmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936473AbWLFQme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:42:34 -0500
Received: from xenotime.net ([66.160.160.81]:32956 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936463AbWLFQme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:42:34 -0500
Date: Wed, 6 Dec 2006 08:43:17 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: "H. J. Lu" <hjl@lucon.org>
Cc: gcc@gcc.gnu.org, GNU C Library <libc-alpha@sources.redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Change x86 prefix order
Message-Id: <20061206084317.4c0ef28d.rdunlap@xenotime.net>
In-Reply-To: <20061206070014.GA535@lucon.org>
References: <20061206070014.GA535@lucon.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 23:00:14 -0800 H. J. Lu wrote:

> On x86, the order of prefix SEG_PREFIX, ADDR_PREFIX, DATA_PREFIX and
> LOCKREP_PREFIX isn't fixed. Currently, gas generates
> 
> LOCKREP_PREFIX ADDR_PREFIX DATA_PREFIX SEG_PREFIX
> 
> I will check in a patch:
> 
> http://sourceware.org/ml/binutils/2006-12/msg00054.html
> 
> tomorrow and change gas to generate
> 
> SEG_PREFIX ADDR_PREFIX DATA_PREFIX LOCKREP_PREFIX

Hi,
Could you provide a "why" for this in addition to the
"what", please?

---
~Randy
