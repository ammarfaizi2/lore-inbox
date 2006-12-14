Return-Path: <linux-kernel-owner+w=401wt.eu-S932401AbWLNLbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWLNLbS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLNLbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:31:18 -0500
Received: from [81.2.110.250] ([81.2.110.250]:43753 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932401AbWLNLbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:31:17 -0500
Date: Thu, 14 Dec 2006 11:39:33 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: tglx@linutronix.de
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Userspace I/O driver core
Message-ID: <20061214113933.07140f0a@localhost.localdomain>
In-Reply-To: <1166095336.29505.97.camel@localhost.localdomain>
References: <20061214010608.GA13229@kroah.com>
	<20061214105235.46c080ae@localhost.localdomain>
	<1166095336.29505.97.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 12:22:16 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 2006-12-14 at 10:52 +0000, Alan wrote:
> > Might be kind of hairy given uio_read() doesn't even return from the
> > kernel. 
> 
> We probably talk about different code here, right ? The one, I'm looking
> at returns on each interrupt event.

The patch Greg posted up has no return inside the while loop.

Alan
