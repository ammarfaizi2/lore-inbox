Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWDSSCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWDSSCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWDSSCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:02:08 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:19572 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751098AbWDSSCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:02:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qE6K7uzabhRT5DpOs8wCx2GjKOeyiCkqZbS1L0iVIUeDZQqS/tkP1SB7ArpZou5JXQm/233p0NTYnP1+ONZl/f2M2f2DzC6KM1KsyrBVwMObMjJ21H9YXrxdsh9gcbEWeY8rAqYSCbQqYX4MHCah3KVGykJODaiSuxjhM9o3jzk=
Date: Wed, 19 Apr 2006 20:00:01 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-Id: <20060419200001.fe2385f4.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone give a long high-level description of what splice() and tee()
are? I need a description for wiki.kernelnewbies.org/Linux_2_6_17 (while
we're it, it'd be nice if some people can review it in case it's missing
something ;) I've named it "generic zero-copy mechanism" but I bet
there's a better description, if it's so cool as people says it'd be nice
to do some "advertising" of it (notifying people of new features is not
something linux has done too well historically :)

What kind of apps available today could get performance benefits by using
this? Is there a new class of "processes" (or apps) that couldn't be done
and can be done now using splice, or are there some kind of apps that become
too complex internally today because they try to avoid extra copy of data
and they can get much simpler by using splice? Why people sees it as a
"radical" improvement in some cases over the typical way of doing I/O in
Unix. Is this similar or can be compared with ritchie's/SYSV STREAMS?
