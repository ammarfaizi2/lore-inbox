Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993036AbWJUNmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993036AbWJUNmL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 09:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993041AbWJUNmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 09:42:11 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:37801 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S2993036AbWJUNmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 09:42:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Add include/linux/freezer.h and move definitions from sched.h
Date: Sat, 21 Oct 2006 15:41:18 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>,
       suspend2-devel <suspend2-devel@lists.suspend2.net>
References: <1161433266.7644.7.camel@nigel.suspend2.net>
In-Reply-To: <1161433266.7644.7.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211541.19050.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 21 October 2006 14:21, Nigel Cunningham wrote:
> Move process freezing functions from include/linux/sched.h to freezer.h,

Hm, I'd rather move them to suspend.h.  Is there any reason for introducing
yet another header file?

> so that modifications to the freezer or the kernel configuration don't
> require recompiling just about everything.

Yes, that's annoying.

Greetings,
Rafael
