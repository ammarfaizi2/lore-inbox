Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbTDJWmH (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264224AbTDJWmH (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:42:07 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31395
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264223AbTDJWmG (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 18:42:06 -0400
Subject: Re: PATCH: Fixes for ide-disk.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030410183839.GC4293@zaurus.ucw.cz>
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
	 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
	 <1049570711.3320.2.camel@laptop-linux.cunninghams>
	 <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
	 <20030410183839.GC4293@zaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050011724.12930.138.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Apr 2003 22:55:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 19:38, Pavel Machek wrote:
> Hi!
> 
> > > Okay. We need a different solution then, but the problem remains - the
> > > driver can get multiple, nexted calls to block and unblock. Can it
> > > become a counting lock?
> > 
> > Blocked is a binary power management described state, its not a lock.
> > What are you actually trying to do ?
> 
> He's trying to fix swsusp. Just now it likes
> to BUG() for some people.

I meant at a slightly lower and more detailed level

