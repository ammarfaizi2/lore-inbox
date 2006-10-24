Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWJXOLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWJXOLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWJXOLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:11:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:58585 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030355AbWJXOLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:11:01 -0400
From: Andi Kleen <ak@suse.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] x86: Extract segment descriptor definitions for use outside of x86_64
Date: Tue, 24 Oct 2006 07:10:30 -0700
User-Agent: KMail/1.9.1
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com> <200610232219.46369.ak@suse.de> <453E1886.8010608@qumranet.com>
In-Reply-To: <453E1886.8010608@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610240710.30727.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 October 2006 06:43, Avi Kivity wrote:
> Code that wants to use struct desc_struct cannot do so on i386 because
> desc.h contains other code that will only compile on x86_64.
>
> So extract the structure definitions into a asm-x86_64/desc_defs.h.
Added thanks
-Andi
