Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTHVWZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTHVWZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:25:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:41691 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261941AbTHVWZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:25:03 -0400
Date: Fri, 22 Aug 2003 15:17:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: <torvalds@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs
 explaining to you?
In-Reply-To: <Pine.LNX.4.33.0308221512360.2310-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0308221516090.2310-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > How is strlen(NULL) better than strncpy(_, NULL, _)?

Actually, the string should not NULL, but merely empty. Neither strlen() 
nor strncpy() will check for a NULL string. 

My other argument still stands.


	Pat

