Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264941AbUE0SPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUE0SPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUE0SPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:15:13 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:34973 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264923AbUE0SPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:15:09 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 27 May 2004 11:15:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: viro@parcelfarce.linux.theplanet.co.uk
cc: FabF <fabian.frederick@skynet.be>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7-rc1-mm1] lp int copy_to_user replaced
In-Reply-To: <20040527180118.GQ12308@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0405271106240.12678@bigblue.dev.mdolabs.com>
References: <1085679127.2070.21.camel@localhost.localdomain>
 <20040527180118.GQ12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Thu, May 27, 2004 at 07:32:08PM +0200, FabF wrote:
> > Andrew,
> > 
> > 	Here's a patch to have standard __put_user for integer transfers in lp
> > driver.Is it correct ?
> 
> What the hell for?  copy_to_user()/copy_from_user() is perfectly OK here.

Andrew love __put_user() against __copy_to_user() :-) We had a similar 
discussion last week.



- Davide

