Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVCRFur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVCRFur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 00:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVCRFur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 00:50:47 -0500
Received: from codepoet.org ([166.70.99.138]:51180 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S261440AbVCRFul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 00:50:41 -0500
Date: Thu, 17 Mar 2005 22:50:40 -0700
From: Erik Andersen <andersen@codepoet.org>
To: lm@bitmover.com, Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BKCVS broken ?
Message-ID: <20050318055040.GA16780@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org, lm@bitmover.com,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050317144522.GK22936@hottah.alcove-fr> <20050318001053.GA23358@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318001053.GA23358@bitmover.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 17, 2005 at 04:10:53PM -0800, Larry McVoy wrote:
> I got swamped, I'll look at this after dinner.  But you might take a look
> at this: http://www.bitkeeper.com/press/2005-03-17.html which is a link
> to a very simple open source BK client.  It doesn't do much except track
> the head of the tree but it does that well.  It's slightly better than
> that, it puts all the checkin comments in BK/ChangeLog so you don't have
> to go over the wire to get those.
> 
> It's intended for someone who just wants the latest and greatest snapshot,
> knows how to do cp -rp and diff -Nur, it's pretty basic.  It's not a
> CVS gateway replacement but it does work for every tree on bkbits.net.
> Just to be clear, we are not dropping the CVS gateway, this is "in
> addition to" not "instead of".

Thanks!  Its nice to finally have an open source tool for sucking
down the latest and greatest directly from bk.  Thus far the tool
is working perfectly at fetching source trees and at updating
them when new patches are applied.

One minor nit.  The name for the 'update' tool is a bit too
generic...  For example old (old) linux systems have an
/sbin/update util for flushing buffers, and I have plenty of
'update' scripts lying around doing odd jobs.   Perhaps a rename
to 'sfioup' might be a good idea, as that is sufficiently obscure
there is little chance of a naming collision.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
