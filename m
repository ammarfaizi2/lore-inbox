Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVAKVdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVAKVdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVAKVcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:32:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58004 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262831AbVAKVad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:30:33 -0500
Subject: Re: [PATCH] Kprobes /proc entry
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Luca Falavigna <dktrkranz@gmail.com>, vamsi_krishna@in.ibm.com,
       prasanna@in.ibm.com, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050110181445.GA31209@kroah.com>
References: <41E2AC82.8020909@gmail.com>  <20050110181445.GA31209@kroah.com>
Content-Type: text/plain
Message-Id: <1105479077.17592.8.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 Jan 2005 15:31:17 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 12:14, Greg KH wrote:
> On Mon, Jan 10, 2005 at 05:25:38PM +0100, Luca Falavigna wrote:
> > This simple patch adds a new file in /proc, listing every kprobe which
> > is currently registered in the kernel. This patch is checked against
> > kernel 2.6.10
> 
> No, please do not add extra /proc files to the kernel.  This belongs in
> /sys, as it has _nothing_ to do with processes.

Wouldn't this sort of thing be a good candidate for debugfs?  If you're
messing with kprobes, then aren't you by definition doing kernel
debugging? :)


Nathan


