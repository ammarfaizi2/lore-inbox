Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVKOPkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVKOPkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVKOPkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:40:10 -0500
Received: from main.gmane.org ([80.91.229.2]:41691 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932544AbVKOPkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:40:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: walt <wa1ter@myrealbox.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9i aka 1.0rc2
Date: Tue, 15 Nov 2005 07:26:37 -0800
Organization: none
Message-ID: <Pine.LNX.4.64.0511150715390.17817@x2.ybpnyarg>
References: <7vr79isfy9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-227-15.dsl.irvnca.pacbell.net
In-Reply-To: <7vr79isfy9.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Nov 2005, Junio C Hamano wrote:

> GIT 0.99.9i aka 1.0rc2 is found at usual places.
>
> I think the source-tree-wise almost everything is done except:
>
>  - http-fetch file descriptor leak fix; I tried Nick's
>    clean-ups, but haven't tried Pasky's patch yet.  Walt reports
>    neither patch fixed the problem.  I wasted the weekend not
>    being able to reproduce this myself, until Pasky reminded me
>    that I have an old special code in git-clone, which was
>    unrelated to this problem, but nevertheless was masking it.

So, you're saying that you have *not* fixed it?  Hm.  Using the
up-to-the-minute repository versions of cogito and git I can now
do a successful clone of the git repository with ulimit -n 64,
which I couldn't do two days ago.  When I get home I'll try it
again on NetBSD also.


