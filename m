Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422928AbWBIRty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422928AbWBIRty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWBIRty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:49:54 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:50078 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1422928AbWBIRtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:49:53 -0500
Date: Thu, 9 Feb 2006 12:50:31 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org,
       saw@sawoct.com
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
Message-ID: <20060209175031.GB6945@ccure.user-mode-linux.org>
References: <43E7C65F.3050609@openvz.org> <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com> <20060209021828.GC9456@ccure.user-mode-linux.org> <43EB518F.6000905@openvz.org> <20060209154046.GA3814@ccure.user-mode-linux.org> <43EB6474.60903@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EB6474.60903@sw.ru>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 06:49:08PM +0300, Kirill Korotaev wrote:
> I mean how CPU time is distributed not only in the case of CPU hogs. For 
> example, when 2 tasks do cyclic 1 byte transfer via pipe. one of them is 
> awake, while another goes to sleep.
> If both are in one container, will they behave like a CPU hog?

So if you have a container with processes taking turns running, so
that there is always a running process, does the container as a whole
act as a CPU hog?

I'll see if I can resurrect it and see.

				Jeff
