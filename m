Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUHBQHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUHBQHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUHBQHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:07:17 -0400
Received: from news.cistron.nl ([62.216.30.38]:50376 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S266582AbUHBQHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:07:15 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: OLS and console rearchitecture
Date: Mon, 2 Aug 2004 16:07:14 +0000 (UTC)
Organization: Cistron Group
Message-ID: <celori$joe$1@news.cistron.nl>
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com> <410E55AA.8030709@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1091462834 20238 62.216.29.200 (2 Aug 2004 16:07:14 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <410E55AA.8030709@ums.usu.ru>,
Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
>Jon Smirl wrote:
>> 15) Over time user space console will be moved to a model where VT's
>> are implemented in user space. This allows user space console access to
>> fully accelerated drawing libraries. This might allow removal of all of
>> the tty/vc layer code avoiding the need to fix it for SMP.
>
>One more minor problem. We need to ensure somehow that the "killall5" 
>program from the sysvinit package will not kill our userspace console 
>daemon at shutdown (got this when I tried to put fbiterm into 
>initramfs). What is the best way to achieve that?

A configuration file for killall5 in which services/daemons get
defined that should not be signalled ?

Mike.
-- 
The question is, what is a "manamanap".
The question is, who cares ?

