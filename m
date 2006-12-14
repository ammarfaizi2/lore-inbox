Return-Path: <linux-kernel-owner+w=401wt.eu-S932638AbWLNLhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWLNLhU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWLNLhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:37:20 -0500
Received: from www.osadl.org ([213.239.205.134]:48218 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932638AbWLNLhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:37:19 -0500
From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Userspace I/O driver core
Date: Thu, 14 Dec 2006 12:37:16 +0100
User-Agent: KMail/1.9.5
Cc: tglx@linutronix.de, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20061214010608.GA13229@kroah.com> <1166095336.29505.97.camel@localhost.localdomain> <20061214113933.07140f0a@localhost.localdomain>
In-Reply-To: <20061214113933.07140f0a@localhost.localdomain>
Organization: Linutronix
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141237.16535.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 12:39 schrieb Alan:
> On Thu, 14 Dec 2006 12:22:16 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Thu, 2006-12-14 at 10:52 +0000, Alan wrote:
> > > Might be kind of hairy given uio_read() doesn't even return from the
> > > kernel. 
> > 
> > We probably talk about different code here, right ? The one, I'm looking
> > at returns on each interrupt event.
> 
> The patch Greg posted up has no return inside the while loop.
> 

There are three breaks in that while loop, the first makes it return as 
soon as an interrupt occurs.

Hans
