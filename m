Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751802AbWIRQH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWIRQH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbWIRQH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:07:27 -0400
Received: from smtp-out.google.com ([216.239.33.17]:44335 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751802AbWIRQH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:07:26 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=atnsbYo0JHIQR1QzFT4c9Haztd651mTg8V/Ko6/nSi3C73DUSI41RPeXc8tdH84If
	xifgdbb+NcJcdHyYQtpNQ==
Subject: Re: [ckrm-tech] [patch 0/5]-Containers: Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: balbir@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <450E9ED9.2060306@in.ibm.com>
References: <1158284264.5408.144.camel@galaxy.corp.google.com>
	 <450E9ED9.2060306@in.ibm.com>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 18 Sep 2006 09:06:10 -0700
Message-Id: <1158595571.18533.5.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 18:57 +0530, Balbir Singh wrote:
> Rohit Seth wrote:
> 
> > Below is a one line description for patches that will follow:
> > 
> > [patch01]: Documentation on how to use containers
> > (Documentation/container.txt)
> > 
> > [patch02]: Changes in the generic part of kernel code
> > 
> > [patch03]: Container's interface with configfs
> > 
> > [patch04]: Core container support
> > 
> > [patch05]: Over the limit memory handler.
> >
> 
> Hi, Rohit,
> 
> The patches are hard to follow - are they diff'ed with Naurp?
> At certain places I cannot figure out which function has changed.
> 

They are without p option so the function name is not there. Though
there is only one patch 02 of 05 that modifies existing code.  And that
too almost all single line changes are starting with container API
container_*  Please let me know if there is something specific that is
not clear.

I will send the next version of patches and I will include -p option as
well.

thanks,
-rohit

