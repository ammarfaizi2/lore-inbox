Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVAJSSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVAJSSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVAJSQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:16:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52608 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262410AbVAJSO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:14:57 -0500
Date: Mon, 10 Jan 2005 10:14:45 -0800
From: Greg KH <greg@kroah.com>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: vamsi_krishna@in.ibm.com, prasanna@in.ibm.com, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kprobes /proc entry
Message-ID: <20050110181445.GA31209@kroah.com>
References: <41E2AC82.8020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2AC82.8020909@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:25:38PM +0100, Luca Falavigna wrote:
> This simple patch adds a new file in /proc, listing every kprobe which
> is currently registered in the kernel. This patch is checked against
> kernel 2.6.10

No, please do not add extra /proc files to the kernel.  This belongs in
/sys, as it has _nothing_ to do with processes.

thanks,

greg k-h
