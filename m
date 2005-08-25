Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVHYVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVHYVsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVHYVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:48:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:57776 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964860AbVHYVsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:48:03 -0400
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, John Rose <johnrose@austin.ibm.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050825162118.GH25174@austin.ibm.com>
References: <20050823231817.829359000@bilge>
	 <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com>
	 <1124898331.24668.33.camel@sinatra.austin.ibm.com>
	 <20050824162959.GC25174@austin.ibm.com>
	 <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
	 <1124930943.5159.168.camel@gaston>  <20050825162118.GH25174@austin.ibm.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 07:43:57 +1000
Message-Id: <1125006237.12539.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 11:21 -0500, Linas Vepstas wrote:
> On Thu, Aug 25, 2005 at 10:49:03AM +1000, Benjamin Herrenschmidt was heard to remark:
> > 
> > Of course, we'll possibly end up with a different ethX or whatever, but
> 
> Yep, but that's not an issue, since all the various device-naming
> schemes are supposed to be fixing this. Its a distinct problem;
> it needs to be solved even across cold-boots. 

Ok, so what is the problem then ? Why do we have to wait at all ? Why
not just unplug/replug right away ?

> (Didn't I ever tell you about the day I added a new disk controller to
> my system, and /dev/hda became /dev/hde and thus /home was mounted on
> /usr and /var as /etc and all hell broke loose? Owww, device naming
> is a serious issue for home users and even more so for enterprise-class 
> users).
> 
> --linas
> 

