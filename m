Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWDSXWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWDSXWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWDSXWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:22:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751319AbWDSXWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:22:46 -0400
Date: Wed, 19 Apr 2006 19:21:52 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Seth Arnold <seth.arnold@suse.de>
cc: Crispin Cowan <crispin@novell.com>, Arjan van de Ven <arjan@infradead.org>,
       Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
In-Reply-To: <20060419231831.GE13761@suse.de>
Message-ID: <Pine.LNX.4.63.0604191920290.11063@cuia.boston.redhat.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
 <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
 <1145470230.3085.84.camel@laptopd505.fenrus.org> <44468817.5060106@novell.com>
 <Pine.LNX.4.63.0604191904370.11063@cuia.boston.redhat.com>
 <20060419231831.GE13761@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Seth Arnold wrote:
> On Wed, Apr 19, 2006 at 07:05:08PM -0400, Rik van Riel wrote:
> > Are confined processes always restricted from starting
> > non-confined processes?
> 
> It is specified in policy via an unconstrained execution flag: 'ux'. Any 
> unconfined children can of course do whatever they wish.

And the default is for the children to inherit the security
policy from the parent process, like in SELinux ?

How do apparmor and selinux differ in how they contain bad
things?

-- 
All Rights Reversed
