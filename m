Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUGHWMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUGHWMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUGHWMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:12:17 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:23428 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264960AbUGHWMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:12:15 -0400
Subject: Re: GCC 3.4 and broken inlining.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040708210925.GA13908@devserv.devel.redhat.com>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
	 <20040708120719.GS21264@devserv.devel.redhat.com>
	 <20040708205225.GI28324@fs.tum.de>
	 <20040708210925.GA13908@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1089324501.3098.9.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 09 Jul 2004 08:08:21 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-09 at 07:09, Arjan van de Ven wrote:
> the problem I've seen is that when gcc doesn't honor normal inline, it will
> often error out if you always inline....
> I'm open to removing the < 4 but as jakub said, 3.4 is quit good at honoring
> normal inline, and when it doesn't there often is a strong reason.....

I'm busy for the next couple of days, but if you want, I'll make
allyesconfig next week and go through fixing the compilation errors so
that the < 4 can be removed. Rearranging code so that inline functions
are defined before they're called or not declared inline if they can't
always be inlined seems to me to be the right thing to do. (Feel free to
say I'm wrong!).

Regards,

Nigel

