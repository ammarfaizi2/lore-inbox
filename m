Return-Path: <linux-kernel-owner+w=401wt.eu-S1760625AbWLJKUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760625AbWLJKUW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 05:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760630AbWLJKUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 05:20:22 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51905 "EHLO outpost.ds9a.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760625AbWLJKUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 05:20:21 -0500
Date: Sun, 10 Dec 2006 11:20:20 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DISCUSS] Optimizing linux applications with the help of the kernel.
Message-ID: <20061210102019.GA27748@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Amit Choudhary <amit2030@yahoo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <464448.56474.qm@web55602.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464448.56474.qm@web55602.mail.re4.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 02:06:49AM -0800, Amit Choudhary wrote:
> In both these cases the same data is coming from kernel_to_user and then from user_to_kernel. If
> this can be short-circuited, that is, from kernel_to_kernel then the performance can be increased
> a lot.

Google on 'splice linux'. It can't do what you want right now exactly, but
it might.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
