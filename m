Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVGCSyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVGCSyI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGCSyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 14:54:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261487AbVGCSyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 14:54:05 -0400
Date: Sun, 3 Jul 2005 14:53:17 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Tony Jones <tonyj@suse.de>
cc: serge@hallyn.com, Greg KH <greg@kroah.com>, <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
In-Reply-To: <20050703182505.GA29491@immunix.com>
Message-ID: <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2005, Tony Jones wrote:

> There just isn't enough content to justify a stacker specific filesystem IMHO.

It might be worth thinking about a more general securityfs as part of LSM,
to be used by stacker and LSM modules.  SELinux could use this instead of
managing its own selinuxfs.


- James
-- 
James Morris
<jmorris@redhat.com>


