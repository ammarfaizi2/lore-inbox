Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVAGOvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVAGOvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVAGOvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:51:02 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:7742 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261444AbVAGOux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:50:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=MAUQhBqLAqeMLVffHT973jH8T4+9ETVvxzhiX5Yhkfn0yUhTQz6nIYN0CXZh+yLGSRldsiGpCst58DBeL+lV8NjyZ8RRCy2b9WgLindz44plaPQJY0yxoFDYR0412UijtkhNaxiFHEnK8pRFzSTNJEHUgxw0J2VN1EG5modvRZA=
Message-ID: <297f4e01050107065060e0b2ad@mail.gmail.com>
Date: Fri, 7 Jan 2005 15:50:52 +0100
From: Ikke <ikke.lkml@gmail.com>
Reply-To: Ikke <ikke.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kobject_uevent
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the new features of 2.6.10 (well, AFAIK its new) is the
kobject_uevent function set.
Currently only some places send out events like this, so I was
thinking to add some more.

Question is: how can I test this? Is there any userland program that
catches these events and prints some information on them to the
screen?

I found out Kay Siever and RML's (maybe some others too?) work on
kernel->userspace events, but the syntax used there seems to be
somewhat different. Kay's got a listener
(http://vrfy.org/projects/kdbusd/kdbusd.c), but is this one
compatible?

Regards, Ikke
