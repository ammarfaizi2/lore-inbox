Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbUKDXGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUKDXGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUKDWg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:36:29 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:47620 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262349AbUKDWV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:21:29 -0500
Date: Thu, 4 Nov 2004 22:21:22 +0000
From: John Levon <levon@movementarian.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org, edwardsg@sgi.com, dipankar@in.ibm.com
Subject: Re: contention on profile_lock
Message-ID: <20041104222122.GA55794@compsoc.man.ac.uk>
References: <200411021152.16038.jbarnes@engr.sgi.com> <20041104201257.GA14786@holomorphy.com> <200411041249.21718.jbarnes@engr.sgi.com> <200411041355.27228.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041355.27228.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CPpyu-000LZ0-9W*HGxjWiPdRbU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 01:55:27PM -0800, Jesse Barnes wrote:

> +/* Oprofile timer tick hook */
> +int (*oprofile_timer_notify)(struct pt_regs *);

How is the module going to access this if you don't EXPORT_SYMBOL_GPL()
it ?

Do you have some specific objection to keeping the register/unregister
functions as I showed?

john
