Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUG1VBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUG1VBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUG1VBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:01:45 -0400
Received: from the-village.bc.nu ([81.2.110.252]:42906 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263714AbUG1VA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:00:58 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org
In-Reply-To: <35250000.1091043768@flay>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <200407280903.37860.jbarnes@engr.sgi.com>
	 <m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
	 <200407281106.17626.jbarnes@engr.sgi.com>  <35250000.1091043768@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091044597.31700.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 20:56:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-07-28 at 20:42, Martin J. Bligh wrote:
> > We'll have to do something about incoming dma traffic and other stuff that the 
> > devices might be doing.  Maybe a arch specific callout to do some chipset 
> > stuff?
> 
> I vote for sleeping for 5 seconds ;-) Should kill off most of it ...

Wake up smell the coffee.

- Bus masters that run forever
- Devices that need to flush before reset is asserted (eg IDE disk)

...

