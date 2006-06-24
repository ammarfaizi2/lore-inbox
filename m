Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932874AbWFXGcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbWFXGcv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 02:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbWFXGcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 02:32:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932874AbWFXGcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 02:32:51 -0400
Date: Fri, 23 Jun 2006 23:32:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: jlan@sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Revised locking for taskstats interface
Message-Id: <20060623233245.77f365bb.akpm@osdl.org>
In-Reply-To: <449C2A44.9000206@watson.ibm.com>
References: <449C2A44.9000206@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 13:52:04 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> Convert locking used within taskstats interface and delay accounting
> code to be more fine-grained.

This patch is based on
per-task-delay-accounting-taskstats-interface-fix-exit-race-in-per-task-delay-accounting.patch,
which I've noted as `nacked' but didn't drop.

So I guess that's now un-nacked?
