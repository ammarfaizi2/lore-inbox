Return-Path: <linux-kernel-owner+w=401wt.eu-S1751698AbWLMWpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWLMWpO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWLMWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:45:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:42385 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbWLMWpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:45:12 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tglx@linutronix.de
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1166049656.29505.49.camel@localhost.localdomain>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <1166044471.11914.195.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
	 <1166048081.11914.208.camel@localhost.localdomain>
	 <1166049656.29505.49.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 09:45:00 +1100
Message-Id: <1166049901.11914.220.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 23:40 +0100, Thomas Gleixner wrote:
> On Thu, 2006-12-14 at 09:14 +1100, Benjamin Herrenschmidt wrote:
> > Oh, it works well enough for non shared iqs if you are really anal about
> 
> It works well for shared irqs. Thats the whole reason why you need an in
> kernel part.

As soon as you have an in-kernel part that is chip specific, yes, of
course it works, because essentially, what you have done is a kernel
driver for your chip and the whole discussion is moot :-) And I agree,
that's the right thing to do btw.

Ben.


