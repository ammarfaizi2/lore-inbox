Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUC3SOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbUC3SOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:14:51 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18120 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263798AbUC3SOt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:14:49 -0500
Content-Type: text/plain;
  charset="koi8-r"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: alex@clusterfs.com
Subject: Re: [Ext2-devel] Re: [RFC, PATCH] Reservation based ext3 preallocation
Date: Tue, 30 Mar 2004 10:07:16 -0800
User-Agent: KMail/1.4.1
Cc: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       tytso@mit.edu, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200403190846.56955.pbadari@us.ibm.com> <200403300907.33995.pbadari@us.ibm.com> <1080666763.2119.20.camel@bzzz.home.net>
In-Reply-To: <1080666763.2119.20.camel@bzzz.home.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200403301007.16123.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 09:12 am, Alex Tomas wrote:
> On ÷ÔÒ, 2004-03-30 at 21:07, Badari Pulavarty wrote:
> > Can you explain this a little more ?  What does b->data and
> > b->commited_data represent ?  We are assuming that b->data will always be
> > uptodate.
>
> b_data represents actual information about used/free blocks.
> b_committed_data represents blocks that freed during current
> transaction. these blocks must not be allocated. there is good
> note about this just before ext3_test_allocatable() in balloc.c

Yes.  I read the note after sending the mail. 

Thanks,
Badari
