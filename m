Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269140AbUINC63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269140AbUINC63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269125AbUINC6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:58:10 -0400
Received: from holomorphy.com ([207.189.100.168]:21648 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269144AbUINCzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:55:09 -0400
Date: Mon, 13 Sep 2004 19:54:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [procfs] [1/1] fix task_mmu.c text size reporting
Message-ID: <20040914025458.GU9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914025304.GT9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914025304.GT9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 07:53:04PM -0700, William Lee Irwin III wrote:
> Not all binfmts page align ->end_code and ->start_code, so the task_mmu
> statistics calculations need to perform this allocation themselves.

s/allocation/alignment/


-- wli
