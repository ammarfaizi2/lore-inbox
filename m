Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266020AbUAQCYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUAQCYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:24:45 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:50100 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S266020AbUAQCYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:24:44 -0500
Date: Fri, 16 Jan 2004 18:24:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg Fitzgerald <gregf@bigtimegeeks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4
Message-ID: <20040117022410.GT1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Greg Fitzgerald <gregf@bigtimegeeks.com>,
	linux-kernel@vger.kernel.org
References: <20040115225948.6b994a48.akpm@osdl.org> <20040117013115.GA5524@evilbint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117013115.GA5524@evilbint>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 08:31:15PM -0500, Greg Fitzgerald wrote:
> Hi,
> 
> 	Just gave 2.6.1-mm4 a try hoping to fix my NFS problems. NFS seems
> to be working better but now my mouse is not working properly. I have
> psmouse.psmouse_proto=exps in my grub.conf. Anyone have ideas? Thanks in advance.

Are you getting stale filehandle from a 2.6 nfs server?

I'm testing 2.6.1-bk2 + [1] to see if it fixes the trouble I've been having
with that.  Maybe you can confirm...

Mike

1. http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/nfsd-01-stale-filehandles-fixes.patch
