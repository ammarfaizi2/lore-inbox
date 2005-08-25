Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVHYQXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVHYQXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVHYQXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:23:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13968 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932285AbVHYQXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:23:32 -0400
Date: Thu, 25 Aug 2005 11:21:18 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, John Rose <johnrose@austin.ibm.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20050825162118.GH25174@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com> <1124898331.24668.33.camel@sinatra.austin.ibm.com> <20050824162959.GC25174@austin.ibm.com> <17165.3205.505386.187453@cargo.ozlabs.ibm.com> <1124930943.5159.168.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124930943.5159.168.camel@gaston>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 10:49:03AM +1000, Benjamin Herrenschmidt was heard to remark:
> 
> Of course, we'll possibly end up with a different ethX or whatever, but

Yep, but that's not an issue, since all the various device-naming
schemes are supposed to be fixing this. Its a distinct problem;
it needs to be solved even across cold-boots. 

(Didn't I ever tell you about the day I added a new disk controller to
my system, and /dev/hda became /dev/hde and thus /home was mounted on
/usr and /var as /etc and all hell broke loose? Owww, device naming
is a serious issue for home users and even more so for enterprise-class 
users).

--linas


