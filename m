Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWCLK6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWCLK6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWCLK6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:58:14 -0500
Received: from main.gmane.org ([80.91.229.2]:2705 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932122AbWCLK6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:58:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Michal Feix <michal@feix.cz>
Subject: Re: Linux v2.6.16-rc6
Date: Sun, 12 Mar 2006 10:57:55 +0000 (UTC)
Message-ID: <loom.20060312T115442-894@post.gmane.org>
References: <fa.B/Q39e5tdKA8fofqhtAW7OLh/1U@ifi.uio.no> <20060312032840.GA1165818@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.101.86.158 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once upon a time, David S. Miller <davem <at> davemloft.net> said:
> >> TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
> >> 148470938:148470943. Repaired.
> >
> >It is a problem with the remote TCP implementation, it is
> >illegally advertising a smaller window that it previously
> >did.
> 
> Is this something that should be logged though?  I get these messages
> all the time on my mirror server.  It isn't like I can do anything about
> it.  If Linux is generous in what it accepts and can handle it, what is
> the logged error for?

If you do not want to see these messages, simply set TCP_DEBUG to 0 in
include/net/tcp.h. Or simply stop logging everything on level debug, which is
worse as it affects all debug kernel output.

--
Michal Feix


