Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWB0Pmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWB0Pmy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWB0Pmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:42:53 -0500
Received: from ns1.suse.de ([195.135.220.2]:54183 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964788AbWB0Pmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:42:42 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Patch 2/4] Basic reorder infrastructure
Date: Mon, 27 Feb 2006 16:41:37 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
References: <1141053825.2992.125.camel@laptopd505.fenrus.org> <1141054054.2992.130.camel@laptopd505.fenrus.org>
In-Reply-To: <1141054054.2992.130.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271641.37733.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 16:27, Arjan van de Ven wrote:
> This patch puts the infrastructure in place to allow for a reordering of
> functions based inside the vmlinux. The general idea is that it is possible
> to put all "common" functions into the first 2Mb of the code, so that they
> are covered by one TLB entry. This as opposed to the current situation where
> a typical vmlinux covers about 3.5Mb (on x86-64) and thus 2 TLB entries.

Looks good. I will apply that.

-Andi
