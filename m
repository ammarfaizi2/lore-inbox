Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTDISua (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 14:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTDISua (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 14:50:30 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:9470 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263660AbTDISu3 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 14:50:29 -0400
Date: Wed, 9 Apr 2003 11:58:35 -0700
From: Chris Wright <chris@wirex.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, mingo@redhat.com, arjanv@redhat.com,
       alan@redhat.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux authentication / credential management
Message-ID: <20030409115835.A1603@figure1.int.wirex.com>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	torvalds@transmeta.com, mingo@redhat.com, arjanv@redhat.com,
	alan@redhat.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
References: <3946.1049901134@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3946.1049901134@warthog.warthog>; from dhowells@redhat.com on Wed, Apr 09, 2003 at 04:12:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> 
> Would you be willing to consider having a "credential cache" in Linux 2.5 (or
> is this something you'd rather leave to 2.7)?

Did you look at the vfs_cred patch that Trond was floating before
feature freeze?  It doesn't have the session bit, but has the credential
cache, modelled from BSD credentials.

http://marc.theaimsgroup.com/?l=linux-kernel&m=103081213416497&w=2

and the ucred patch which lead to this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103074971719243&w=2

It's certainly simpler, but could it be used as a starting point?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
