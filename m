Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVAGL6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVAGL6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVAGL6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:58:48 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:62144 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261301AbVAGL6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:58:46 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: how to find all threads of a given process?
Date: Fri, 7 Jan 2005 11:58:46 +0000 (UTC)
Organization: Cistron Group
Message-ID: <crlthm$fe7$1@news.cistron.nl>
References: <20050107002333.21133.qmail@web52602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1105099126 15815 62.216.29.200 (7 Jan 2005 11:58:46 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050107002333.21133.qmail@web52602.mail.yahoo.com>,
jesse  <jessezx@yahoo.com> wrote:
>suppose I already know the PID of a process, how could
>i quickly identify all threads of this process? 

With 2.6 and NPTL, you'll find them under /proc/PID/task

>As i know, under /proc, threads of all processes have
>prefix ".", one way is to iterate each one and do the
>check. the approach is too expensive. any other
>suggestions?

I've never seen anything like that. Is that a vendor-patched
kernel, something like Redhat 2.4 + NPTL support ?

Mike.

