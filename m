Return-Path: <linux-kernel-owner+w=401wt.eu-S1751437AbWLLPj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWLLPj7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWLLPj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:39:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43468 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbWLLPj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:39:58 -0500
Date: Tue, 12 Dec 2006 10:39:56 -0500
From: Dave Jones <davej@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make OLPC camera driver depend on x86.
Message-ID: <20061212153956.GH8509@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <20061212145258.GA29952@redhat.com> <12591.1165936372@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12591.1165936372@lwn.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 08:12:52AM -0700, Jonathan Corbet wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > -	depends on I2C && VIDEO_V4L2
 > > +	depends on I2C && VIDEO_V4L2 && X86_32
 > 
 > Any particular reason why?

Just seemed odd to be offered the option when I was building
an ia64 kernel given its extremely unlikely to ever appear there.

[gads, an ia64 olpc, what a thought...]

		Dave

-- 
http://www.codemonkey.org.uk
