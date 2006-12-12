Return-Path: <linux-kernel-owner+w=401wt.eu-S1750992AbWLLJNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWLLJNK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWLLJNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:13:10 -0500
Received: from mx2.go2.pl ([193.17.41.42]:34359 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750992AbWLLJNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:13:08 -0500
Date: Tue, 12 Dec 2006 10:20:14 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: "Jeffrey V\. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recursive spinlocks for Network Recursion Bugs in 2.6.18
Message-ID: <20061212092014.GA1922@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	"Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457A6637.3060101@wolfmountaingroup.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-2006 08:31, Jeffrey V. Merkey wrote:
> 
> 
> This code segment in /net/core/dev.c is a prime example of the need for 
> recursive spin locks.
...
> Recursive spinlocks perform the logic
...
> LONG rspin_lock(rlock_t *rlock)
...
> LONG rspin_unlock(rlock_t *rlock)
...

Could you give some hint how this code from dev.c
should be changed to gain by this?

Jarek P. 
