Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWJJF5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWJJF5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWJJF5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:57:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:30673 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965002AbWJJF5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:57:15 -0400
Subject: Re: driver,platform,firmware,system, data data data ....
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <452B3417.7050106@keyaccess.nl>
References: <1160451368.32237.78.camel@localhost.localdomain>
	 <452B3417.7050106@keyaccess.nl>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 15:57:00 +1000
Message-Id: <1160459820.32237.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 07:48 +0200, Rene Herman wrote:
> Benjamin Herrenschmidt wrote:
> 
> [ device->platform_data ]
> 
> > So except for the size of the patch and boredom of going through all
> > of them fixing them, do you see any reason why this later one
> > shouldn't be moved out to platform_driver ? (I haven't actually
> > checked at all the occurences in the tree though).
> 
> You'll find it being used in drivers/base/isa.c for one. I only used it 
> there because it was available and made for slightly nicer code though. 
> If platform_data is going away (and assuming you wouldn't want similar 
> abuse of your new system_data) it wouldn't be a problem to move the 
> driver pointer to the private struct isa_dev as in the attached.

Ah thanks, I missed that use.

Well, we'll see what Greg has to say but thanks for the patch.

Cheers,
Ben.


