Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWFHGv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWFHGv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWFHGv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:51:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:12768 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932541AbWFHGvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:51:25 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: fix compat mode ptrace() bug
Date: Thu, 8 Jun 2006 08:50:12 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Albert Cahalan <acahalan@gmail.com>
References: <200606080226_MC3-1-C1E2-4DA4@compuserve.com>
In-Reply-To: <200606080226_MC3-1-C1E2-4DA4@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606080850.12577.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 08:23, Chuck Ebbert wrote:
> ptrace(PTRACE_[GS]ETSIGINFO) is broken in ia32 mode on 64-bit kernel,
> as reported by Albert Cahalan.

It's already fixed in the ff tree, or in -mm* 

See ftp://ftp.firstfloor.org/pub/ak/quilt/patches/new-compat-ptrace

Will be merged into 2.6.18.

-Andi
