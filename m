Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVKPACq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVKPACq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 19:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKPACq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 19:02:46 -0500
Received: from main.gmane.org ([80.91.229.2]:41616 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965093AbVKPACq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 19:02:46 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: walt <wa1ter@myrealbox.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9i aka 1.0rc2
Date: Tue, 15 Nov 2005 15:48:58 -0800
Organization: none
Message-ID: <Pine.NEB.4.63.0511151539360.12158@x9.ybpnyarg>
References: <7vr79isfy9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511150715390.17817@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-227-15.dsl.irvnca.pacbell.net
In-Reply-To: <Pine.LNX.4.64.0511150715390.17817@x2.ybpnyarg>
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, walt wrote:

> On Mon, 14 Nov 2005, Junio C Hamano wrote:
>
> > I think the source-tree-wise almost everything is done except:
> >  - http-fetch file descriptor leak fix...

> So, you're saying that you have *not* fixed it?...

I just confirmed the good news on NetBSD.  Out of curiosity I did
this test:  I cg-updated and reinstalled cogito, which did *not*
fix the too-many-open-files error.  Then I cg-updated and rebuilt
git which *did* fix the error.  Clearly, something you committed
in the last two days has fixed this problem.  Dunno what you did,
but thanks :o)


