Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUKKVLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUKKVLC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbUKKVLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:11:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262382AbUKKVLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:11:00 -0500
Date: Thu, 11 Nov 2004 16:10:50 -0500
From: Dave Jones <davej@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI?
Message-ID: <20041111211050.GC32275@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0411112103060.3167-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411112103060.3167-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 09:05:11PM +0000, Hugh Dickins wrote:
 > What is this "VLI" that 2.6.9 started putting after the taint string
 > in i386 oopses?  Vick Library Index?  Vineyard Leadership Institute?

"Variable length instructions".  I think newer ksymoops looks
for this tag and does something magical when doing disassembly.

		Dave

