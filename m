Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVCKRcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVCKRcf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVCKRcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:32:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40127 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261218AbVCKRc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:32:28 -0500
Date: Fri, 11 Mar 2005 11:31:58 -0600
From: Michael Raymond <mraymond@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Message-ID: <20050311113158.L91195@goliath.americas.sgi.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU> <20050311075029.A92696@goliath.americas.sgi.com> <20050311172514.GB1768@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050311172514.GB1768@kroah.com>; from greg@kroah.com on Fri, Mar 11, 2005 at 09:25:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    We have some customers doing high performance raw I/O from various PCI &
VME cards.  They can already mmap() and do DMA from user space to the cards.
Allowing them to do interrupt processing in user space allows them to keep
everything in one tight package.  The ULI web site talks about this a little
more.
     						Thanks,
						       Michael

On Fri, Mar 11, 2005 at 09:25:14AM -0800, Greg KH wrote:
> On Fri, Mar 11, 2005 at 07:50:32AM -0600, Michael Raymond wrote:
> >     I have many users asking for something like this.
> 
> Why would a "user" care about this?
> 
> Now hardware companies that want to write closed drivers is another
> thing :)
> 
> thanks,
> 
> greg k-h

-- 
Michael A. Raymond              Office: (651) 683-3434
Core OS Group                   Real-Time System Software
