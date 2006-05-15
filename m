Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWEOLDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWEOLDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWEOLDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:03:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6351 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964881AbWEOLDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:03:00 -0400
Date: Mon, 15 May 2006 03:59:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: nickpiggin@yahoo.com.au, michael.craig.thompson@gmail.com,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu,
       dhowells@redhat.com
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-Id: <20060515035908.43698be0.akpm@osdl.org>
In-Reply-To: <30035.1147688271@warthog.cambridge.redhat.com>
References: <20060513201341.63590cff.akpm@osdl.org>
	<20060513033742.GA18598@hellewell.homeip.net>
	<44655ECD.10404@yahoo.com.au>
	<afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com>
	<44669D12.5050306@yahoo.com.au>
	<30035.1147688271@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Nobody is going to include a half-applied filesystem in their .config while
> > performing git-bisection, so it can go in in any order.
> 
> Apart from those who routinely attempt "make allyesconfig".
> 

Nobody will use allyesconfig when bisection-searching for a particular bug.
