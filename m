Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbUDAVrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUDAVqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:46:09 -0500
Received: from ns.suse.de ([195.135.220.2]:23748 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263273AbUDAVoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:44:55 -0500
Date: Thu, 1 Apr 2004 23:44:59 +0200
From: Andi Kleen <ak@suse.de>
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Cc: dan@debian.org, weigand@i1.informatik.uni-erlangen.de, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-Id: <20040401234459.191bb6ed.ak@suse.de>
In-Reply-To: <200404012101.XAA23775@faui1d.informatik.uni-erlangen.de>
References: <20040401224604.5c3b45ff.ak@suse.de>
	<200404012101.XAA23775@faui1d.informatik.uni-erlangen.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004 23:01:39 +0200 (CEST)
Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de> wrote:

> Both lead to the same type of problem.

Indeed. My change would only provide a lighter guarantee - time never going backwards.

-Andi
