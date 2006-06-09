Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWFIIBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWFIIBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWFIIBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:01:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751339AbWFIIBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:01:08 -0400
Date: Fri, 9 Jun 2006 01:00:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: jlan@sgi.com, csturtiv@sgi.com, balbir@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060609010057.e454a14f.akpm@osdl.org>
In-Reply-To: <44892610.6040001@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 03:41:04 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> Hence, this patch introduces a configuration parameter
> 	/sys/kernel/taskstats_tgid_exit
> through which a privileged user can turn on/off sending of per-tgid stats on
> task exit.

That seems a bit clumsy.  What happens if one consumer wants the per-tgid
stats and another does not?
