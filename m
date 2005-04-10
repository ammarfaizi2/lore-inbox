Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVDJJC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVDJJC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 05:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVDJJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 05:02:56 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:59853 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261444AbVDJJCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 05:02:55 -0400
Date: Sun, 10 Apr 2005 01:53:40 -0400
From: Christopher Li <lkml@chrisli.org>
To: Junio C Hamano <junkio@cox.net>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050410055340.GB13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 12:51:59AM -0700, Junio C Hamano wrote:
> 
> But I am wondering what your plans are to handle renames---or
> does git already represent them?
>

Rename should just work.  It will create a new tree object and you
will notice that in the entry that changed, the hash for the blob
object is the same.

Chris

