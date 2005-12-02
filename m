Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVLBRfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVLBRfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 12:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVLBRfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 12:35:02 -0500
Received: from tag.witbe.net ([81.88.96.48]:1466 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1750825AbVLBRfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 12:35:01 -0500
Message-Id: <200512021734.jB2HYtD02754@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'J. Bruce Fields'" <bfields@fieldses.org>,
       "'Nico Schottelius'" <nico-kernel@schottelius.org>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'Daniel Aubry'" <kernel-acl@spam.kicks-ass.net>
Subject: Re: ACL Problem
Date: Fri, 2 Dec 2005 18:34:35 +0100
Organization: Witbe.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcX3YcnVPLl4Q/VhQI6Htjlqng4yWQABKpfQ
In-Reply-To: <20051202165923.GA20542@fieldses.org>
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> You probably just need to do something like
> 
> 	mount -oremount,acl /home

Or
	mount -oremount,acl,user_xattr /home
to have complete support... 

> I can't figure out where this is documented, though.
Google.com :)

Paul

