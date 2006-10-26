Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWJZLtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWJZLtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWJZLtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:49:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31635 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161115AbWJZLtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:49:51 -0400
Subject: Re: Security issues with local filesystem caching
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Dittmer <jdi@l4x.org>
Cc: David Howells <dhowells@redhat.com>, sds@tycho.nsa.gov, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <45407C71.5070407@l4x.org>
References: <16969.1161771256@redhat.com>  <45407C71.5070407@l4x.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 12:52:21 +0100
Message-Id: <1161863541.12781.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-26 am 11:14 +0200, ysgrifennodd Jan Dittmer:
> Why again no local userspace daemon to do the caching? That would
> put the policy out of the kernel. The additional context switches
> are probably pretty cheap compared to the io operations.

It costs a lot in latency, and you don't need a daemon in the first
place. If you want to do a user space caching fs of course you can
already do it with FUSE..

