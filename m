Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUBKFEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 00:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUBKFEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 00:04:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263310AbUBKFEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 00:04:09 -0500
Date: Wed, 11 Feb 2004 00:03:59 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Chris PeBenito <pebenito@gentoo.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.3-rc1-mm1 (SELinux + ext3 + nfsd oops)
In-Reply-To: <1076471114.4925.0.camel@chris.pebenito.net>
Message-ID: <Xine.LNX.4.44.0402110000160.10071-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Chris PeBenito wrote:

> Still oopses.  I also tried with 2.6.3-rc2, and it also oopses.

Odd, I'm unable to reproduce the problem with the same server mount
options, export options and client mount options (full details obtained
off-list).

What happens if you boot with selinux=0?

Please make sure you have the nfsd fix if using rc1-mm1.


- James
-- 
James Morris
<jmorris@redhat.com>


