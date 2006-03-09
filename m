Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbWCICVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWCICVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWCICVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:21:50 -0500
Received: from ns1.suse.de ([195.135.220.2]:13465 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932706AbWCICVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:21:49 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
References: <20060308015808.GA9062@localhost.localdomain>
	<20060308015934.GB9062@localhost.localdomain>
	<20060307181301.4dd6aa96.akpm@osdl.org>
	<20060308202656.GA4493@localhost.localdomain>
	<20060308203642.GZ5410@kvack.org>
	<20060308210726.GD4493@localhost.localdomain>
	<20060308211733.GA5410@kvack.org>
	<20060308222528.GE4493@localhost.localdomain>
	<20060308150609.344c62fa.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 09 Mar 2006 03:21:40 +0100
In-Reply-To: <20060308150609.344c62fa.akpm@osdl.org>
Message-ID: <p733bhswe6j.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> 
> x86_64 is signed 32-bit!

I'll change it. You want signed 64bit?

-Andi
