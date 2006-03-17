Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWCQQNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWCQQNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWCQQNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:13:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57989 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030195AbWCQQNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:13:31 -0500
Date: Fri, 17 Mar 2006 16:13:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][1/2] sched: sched.c task_t cleanup
Message-ID: <20060317161330.GA3250@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Con Kolivas <kernel@kolivas.org>,
	linux list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
References: <200603180004.13967.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603180004.13967.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 12:04:13AM +1100, Con Kolivas wrote:
> Replace all task_struct instances in sched.c with task_t

Please do it the other way around and kill task_t.  dito for the other
patches.

