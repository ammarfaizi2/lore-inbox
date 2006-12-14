Return-Path: <linux-kernel-owner+w=401wt.eu-S932593AbWLNLSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWLNLSb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWLNLSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:18:31 -0500
Received: from www.osadl.org ([213.239.205.134]:35979 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932593AbWLNLSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:18:30 -0500
Subject: Re: Userspace I/O driver core
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061214105235.46c080ae@localhost.localdomain>
References: <20061214010608.GA13229@kroah.com>
	 <20061214105235.46c080ae@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 12:22:16 +0100
Message-Id: <1166095336.29505.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 10:52 +0000, Alan wrote:
> Might be kind of hairy given uio_read() doesn't even return from the
> kernel. 

We probably talk about different code here, right ? The one, I'm looking
at returns on each interrupt event.

	tglx


