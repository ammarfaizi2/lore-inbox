Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUFPNBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUFPNBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUFPNAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:00:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38099 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266301AbUFPNAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:00:01 -0400
Subject: Re: JFS compilation fix [was Re: Linux 2.6.7]
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1087390524.29047.10.camel@shaggy.austin.ibm.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040616080740.GC23998@louise.pinerecords.com>
	 <1087390524.29047.10.camel@shaggy.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1087390782.29041.16.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 16 Jun 2004 07:59:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 07:55, Dave Kleikamp wrote:

> jfs_dtree.h is included by jfs_inline.h, and is not needed in jfs_dtree.c.

jfs_incore.h, not inline.  Doh!

