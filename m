Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWJDOWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWJDOWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWJDOWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:22:03 -0400
Received: from [83.101.154.115] ([83.101.154.115]:39296 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161009AbWJDOWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:22:01 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: RE: System hang problem.
Date: Wed, 4 Oct 2006 17:24:12 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041724.12514.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Neema wrote:
> > What you can often do, if you have one application using much memory,
> > is limiting *this application's* memory usage with ulimit. If the
> > application correctly handles malloc()==NULL, then at least your
> > system will behave stably.
>
> The problem is its different application, different user each time (a
> typical large R&D environment). /etc/security/limits.conf allows to set
> max resident set size. Is there a way to limit based on the total
> virtual size?

You mean like: ulimit -v [total VMsize/runqueue]

I suppose, that this could easily be dynamically calculated by the kernel, 
for a tremendously inhibiting OOM-killer effect.


Thanks!

--
Al

