Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbTIKS70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTIKS7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:59:25 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:59025 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261466AbTIKS7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:59:25 -0400
Date: Thu, 11 Sep 2003 19:59:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911185912.GP29532@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <20030911012708.GD3134@wotan.suse.de> <20030911165845.GE29532@mail.jlokier.co.uk> <20030911190516.64128fe9.ak@suse.de> <20030911173245.GJ29532@mail.jlokier.co.uk> <20030911193954.63724a82.ak@suse.de> <20030911174839.GM29532@mail.jlokier.co.uk> <20030911201806.2b2d9c5b.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911201806.2b2d9c5b.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> There are a lot of conditional branches in the signal path. If you
> don't believe me I can send you simics full instruction traces of it.

Oh, I know.  The signal machinery is disturbingly branch-heavy.

-- Jamie
