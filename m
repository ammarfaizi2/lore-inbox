Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264119AbUDVPQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUDVPQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbUDVPQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:16:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51412 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264119AbUDVPQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:16:13 -0400
Date: Thu, 22 Apr 2004 11:15:47 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Large inlines in include/linux/skbuff.h
In-Reply-To: <m3y8ooawiq.fsf@averell.firstfloor.org>
Message-ID: <Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Andi Kleen wrote:

> > How will these changes impact performance?  I asked this last time you 
> > posted about inlines and didn't see any response.
> 
> I don't think it will be an issue. The optimization guidelines
> of AMD and Intel recommend to move functions that generate 
> more than 30-40 instructions out of line. 100 instructions 
> is certainly enough to amortize the call overhead, and you 
> safe some icache too so it may be even faster.

Of course, but it would be good to see some measurements.


- James
-- 
James Morris
<jmorris@redhat.com>


