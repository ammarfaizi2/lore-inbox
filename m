Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVLBRmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVLBRmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 12:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVLBRmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 12:42:10 -0500
Received: from mail.fieldses.org ([66.93.2.214]:46210 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750837AbVLBRmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 12:42:09 -0500
Date: Fri, 2 Dec 2005 12:42:07 -0500
To: Paul Rolland <rol@witbe.net>
Cc: "'Nico Schottelius'" <nico-kernel@schottelius.org>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'Daniel Aubry'" <kernel-acl@spam.kicks-ass.net>
Subject: Re: ACL Problem
Message-ID: <20051202174207.GB20542@fieldses.org>
References: <20051202165923.GA20542@fieldses.org> <200512021734.jB2HYtD02754@tag.witbe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512021734.jB2HYtD02754@tag.witbe.net>
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 06:34:35PM +0100, Paul Rolland wrote:
> Hello,
> 
> > You probably just need to do something like
> > 
> > 	mount -oremount,acl /home
> 
> Or
> 	mount -oremount,acl,user_xattr /home
> to have complete support... 
> 
> > I can't figure out where this is documented, though.
> Google.com :)

Yeah.  I couldn't find anything on any of the man pages I thought to
check, though.  (acl, getfacl, mount, ...)  Seems like an oversight.

--b.
