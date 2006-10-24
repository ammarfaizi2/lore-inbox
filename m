Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWJXM7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWJXM7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWJXM7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:59:22 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:62634 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161060AbWJXM7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:59:21 -0400
Date: Tue, 24 Oct 2006 14:59:09 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] KVM: userspace interface
Message-ID: <20061024125909.GM4943@rhun.haifa.ibm.com>
References: <453CC390.9080508@qumranet.com> <20061023132946.49E62250143@cleopatra.q> <20061024125144.GK4943@rhun.haifa.ibm.com> <453E0D62.8030502@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453E0D62.8030502@qumranet.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 02:56:02PM +0200, Avi Kivity wrote:
> Muli Ben-Yehuda wrote:
> >On Mon, Oct 23, 2006 at 01:29:46PM -0000, Avi Kivity wrote:
> >
> >
> >  
> >>+		struct {
> >>+		} debug;
> >>    
> >
> >ISTR some versions of gcc had problems with empty structs.
> >  
> 
> Any versions >= 3.2, which is the minimum required nowadays?

Don't recall, sorry. But in any case I don't see a problem with
dropping it and re-adding it if debug arguments are needed later.

Cheers,
Muli
