Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161273AbWJKX1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161273AbWJKX1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161280AbWJKX1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:27:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:9661 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161273AbWJKX1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:27:16 -0400
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061011154836.9befa359.akpm@osdl.org>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <20061011131935.448a8696.akpm@osdl.org>
	 <20061011221822.GD7911@ca-server1.us.oracle.com>
	 <20061011154836.9befa359.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Wed, 11 Oct 2006 16:27:13 -0700
Message-Id: <1160609233.6389.82.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 15:48 -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2006 15:18:22 -0700
> Joel Becker <Joel.Becker@oracle.com> wrote:
> 
> > On Wed, Oct 11, 2006 at 01:19:35PM -0700, Andrew Morton wrote:
> > > The patch deletes a pile of custom code from configfs and replaces it with
> > > calls to standard kernel infrastructure and fixes a shortcoming/bug in the
> > > process.  Migration over to the new interface is trivial and almost
> > > scriptable.
> > 
> > 	The configfs stuff is based on the sysfs code too.  Should we
> > migrate sysfs/file.c to the same seq_file code?  Serious question, if
> > the cleanup is considered better.
> > 
> 
> I don't see why not.  I don't know if anyone has though of/proposed it
> before.

I can generate a patch for that too.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


