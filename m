Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVFMNuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVFMNuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVFMNuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:50:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56781 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261573AbVFMNui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:50:38 -0400
Date: Mon, 13 Jun 2005 09:50:29 -0400
From: Neil Horman <nhorman@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Horman <nhorman@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
Message-ID: <20050613135029.GC8810@hmsendeavour.rdu.redhat.com>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com> <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk> <20050611193500.GC1097@devserv.devel.redhat.com> <20050612181006.GC2229@hmsendeavour.rdu.redhat.com> <1118670162.13250.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118670162.13250.25.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 02:42:43PM +0100, Alan Cox wrote:
> On Sul, 2005-06-12 at 19:10, Neil Horman wrote:
> > How about this?  Its the same feature, with an added check in fcntl_dirnotify to
> > ensure that only processes with CAP_SYS_ADMIN set can tell processes preforming
> 
> Once you are monitoring and sending signals I think its time to ask if
> the interface is in totally the wrong place. Would it not be better if
> it was part of the ptrace interface to the monitored process ?
> 

You mean add the ability to monitor directories for changes to the ptrace
interface entirely?

Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
