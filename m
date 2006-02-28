Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWB1Ljb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWB1Ljb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWB1Ljb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:39:31 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:1202 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751502AbWB1Ljb
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 28 Feb 2006 06:39:31 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17412.13937.158404.935427@gargle.gargle.HOWL>
Date: Tue, 28 Feb 2006 14:39:29 +0300
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Newsgroups: gmane.linux.kernel
In-Reply-To: <20060227190150.GA9121@kroah.com>
References: <20060227190150.GA9121@kroah.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

[...]

 > +
 > +  stable/
 > +	This directory documents the interfaces that have determined to
 > +	be stable.  Userspace programs are free to use these interfaces
 > +	with no restrictions, and backward compatibility for them will
 > +	be guaranteed for at least 2 years.  Most simple interfaces
 > +	(like syscalls) are expected to never change and always be
 > +	available.

What about separating "stable" ("guaranteed for at least 2 years") and
"standard" (core unix interface is not going to change ever)?

Nikita.
