Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWBIPjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWBIPjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 10:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWBIPjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 10:39:52 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:20637 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932535AbWBIPjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 10:39:51 -0500
Date: Thu, 9 Feb 2006 10:40:46 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Kirill Korotaev <dev@openvz.org>
Cc: linux-kernel@vger.kernel.org, saw@sawoct.com
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
Message-ID: <20060209154046.GA3814@ccure.user-mode-linux.org>
References: <43E7C65F.3050609@openvz.org> <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com> <20060209021828.GC9456@ccure.user-mode-linux.org> <43EB518F.6000905@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EB518F.6000905@openvz.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 05:28:31PM +0300, Kirill Korotaev wrote:
> >I did this to the scheduler last year - see
> >	http://marc.theaimsgroup.com/?l=linux-kernel&m=111404726721747&w=2
> It's really interesting!
> Have you tested fairness of your solution and it's performance overhead?

What do you mean by fairness, exactly?

As for its overhead, I just got it working inside UML.  I tried it on
x86_64, but something was wrong with the low-level switching stuff,
and the machine hung whenever a guest scheduler process tried to run.
So, I never got any real measurements.

I had better things to do, so I dropped this and went back to them.

				Jeff
