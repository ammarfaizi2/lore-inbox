Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUG1T0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUG1T0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUG1T0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:26:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:14746 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263062AbUG1TZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:25:43 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@osdl.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <20040725235705.57b804cc.akpm@osdl.org>
	 <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	 <200407280903.37860.jbarnes@engr.sgi.com>
	 <m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091038878.31593.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 19:21:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-07-28 at 19:00, Eric W. Biederman wrote:
> Which actually is one of the items open for discussion currently.
> For kexec on panic do we want to run the shutdown() routines?

Probably or you may not be able to recover some devices. In some cases
simply turning off the master bit might be enough however.

