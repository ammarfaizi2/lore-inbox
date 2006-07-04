Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWGDGUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWGDGUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWGDGUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:20:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751213AbWGDGUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:20:37 -0400
Date: Mon, 3 Jul 2006 23:20:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       hugh@veritas.com, kernel@kolivas.org, marcelo@kvack.org,
       nickpiggin@yahoo.com.au, ak@suse.de
Subject: Re: [RFC 3/8] Move HIGHMEM counter into highmem.c/.h
Message-Id: <20060703232020.260446d9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607032253040.10856@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
	<20060703215550.7566.79975.sendpatchset@schroedinger.engr.sgi.com>
	<20060704144724.65c43a38.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0607032253040.10856@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 22:56:36 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> > this should be covered by CONFIG_HIGHMEM if you change totalhigh_pages 
> > to be #define.
> 
> Ok. Will put a #ifdef CONFIG_HIGHMEM around that statement and the 
> following one.

That will take the patchset up to 27 new ifdefs.  Is there a way of improving
that?
