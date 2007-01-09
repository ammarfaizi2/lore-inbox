Return-Path: <linux-kernel-owner+w=401wt.eu-S932074AbXAINsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXAINsK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 08:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXAINsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 08:48:10 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34535 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbXAINsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 08:48:08 -0500
Message-ID: <45A39D0D.7090007@garzik.org>
Date: Tue, 09 Jan 2007 08:47:57 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Stable kvm userspace interface
References: <45A39A97.5060807@qumranet.com>
In-Reply-To: <45A39A97.5060807@qumranet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can we please avoid adding a ton of new ioctls?  ioctls inevitably 
require 64-bit compat code for certain architectures, whereas 
sysfs/procfs does not.

	Jeff



