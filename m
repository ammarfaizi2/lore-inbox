Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTIZK3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 06:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTIZK3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 06:29:38 -0400
Received: from zork.zork.net ([64.81.246.102]:24720 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261399AbTIZK3h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 06:29:37 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: vmware in Linux 2.6
References: <yw1xwubvq3vq.fsf@users.sourceforge.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 26 Sep 2003 11:29:35 +0100
In-Reply-To: <yw1xwubvq3vq.fsf@users.sourceforge.net> 
 =?iso-8859-1?q?=28M=E5ns_Rullg=E5rd's?= message of "Fri, 26 Sep 2003 11:46:01 +0200")
Message-ID: <6u1xu3q1v4.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> Is it possible to use vmware with Linux 2.6?  The kernel modules
> (obviously) fail to compile.

There are three references in the vmnet code that need to be changed
from ->priv to ->sk_priv, or somesuch.  After that, it seems to work
fine.

