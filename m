Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUBKC3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 21:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUBKC3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 21:29:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261774AbUBKC3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 21:29:11 -0500
Date: Tue, 10 Feb 2004 21:29:02 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Chris PeBenito <pebenito@gentoo.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.3-rc1-mm1 (SELinux + ext3 + nfsd oops)
In-Reply-To: <1076457099.29471.39.camel@chris.pebenito.net>
Message-ID: <Xine.LNX.4.44.0402102128210.9747-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Chris PeBenito wrote:

> I got an oops on boot when nfsd is starting up on a SELinux+ext3
> machine.  It exports /home, which is mounted thusly:
> 

What happens if you try this this patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107637246127197&w=2 ?



- James
-- 
James Morris
<jmorris@redhat.com>


