Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUE0SF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUE0SF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbUE0SF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:05:57 -0400
Received: from outmx003.isp.belgacom.be ([195.238.2.100]:9386 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264913AbUE0SF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:05:56 -0400
Subject: Re: [2.6.7-rc1-mm1] lp int copy_to_user replaced
From: FabF <fabian.frederick@skynet.be>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040527180118.GQ12308@parcelfarce.linux.theplanet.co.uk>
References: <1085679127.2070.21.camel@localhost.localdomain>
	 <20040527180118.GQ12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1085681215.2070.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 20:06:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-27 at 20:01, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Thu, May 27, 2004 at 07:32:08PM +0200, FabF wrote:
> > Andrew,
> > 
> > 	Here's a patch to have standard __put_user for integer transfers in lp
> > driver.Is it correct ?
> 
> What the hell for?  copy_to_user()/copy_from_user() is perfectly OK here.
> 
And why the hell use generic functions when we have neat small type
exchange macros ?

FabF

