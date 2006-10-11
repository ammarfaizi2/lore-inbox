Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWJKWtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWJKWtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWJKWtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:49:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965230AbWJKWsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:48:52 -0400
Date: Wed, 11 Oct 2006 15:48:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-Id: <20061011154836.9befa359.akpm@osdl.org>
In-Reply-To: <20061011221822.GD7911@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
	<20061011131935.448a8696.akpm@osdl.org>
	<20061011221822.GD7911@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 15:18:22 -0700
Joel Becker <Joel.Becker@oracle.com> wrote:

> On Wed, Oct 11, 2006 at 01:19:35PM -0700, Andrew Morton wrote:
> > The patch deletes a pile of custom code from configfs and replaces it with
> > calls to standard kernel infrastructure and fixes a shortcoming/bug in the
> > process.  Migration over to the new interface is trivial and almost
> > scriptable.
> 
> 	The configfs stuff is based on the sysfs code too.  Should we
> migrate sysfs/file.c to the same seq_file code?  Serious question, if
> the cleanup is considered better.
> 

I don't see why not.  I don't know if anyone has though of/proposed it
before.
