Return-Path: <linux-kernel-owner+w=401wt.eu-S1751412AbWLLPMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWLLPMx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWLLPMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:12:53 -0500
Received: from vena.lwn.net ([206.168.112.25]:52657 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbWLLPMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:12:53 -0500
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make OLPC camera driver depend on x86. 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 12 Dec 2006 09:52:58 EST."
             <20061212145258.GA29952@redhat.com> 
Date: Tue, 12 Dec 2006 08:12:52 -0700
Message-ID: <12591.1165936372@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:

> -	depends on I2C && VIDEO_V4L2
> +	depends on I2C && VIDEO_V4L2 && X86_32

Any particular reason why?  I wouldn't be surprised to see Cafe used
with other processors in the future.  And I happen to know the driver
works on x86-64 systems...or at least it did a few iterations back.

In any case, x86 for now is fine, I guess; we can always change it later
if need be.

jon

