Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTLLNdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTLLNdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:33:22 -0500
Received: from maclaurence.math.u-psud.fr ([129.175.50.15]:22153 "EHLO
	perso.free.fr") by vger.kernel.org with ESMTP id S264608AbTLLNdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:33:14 -0500
From: Duncan Sands <baldrick@free.fr>
To: Jamie Lokier <jamie@shareable.org>, Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Fri, 12 Dec 2003 14:33:14 +0100
User-Agent: KMail/1.5.4
Cc: =?iso-8859-1?q?M=E5ns=20Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
References: <20031208154256.GV19856@holomorphy.com> <3FD5AB6C.3040008@aitel.hist.no> <20031212112636.GA12727@mail.shareable.org>
In-Reply-To: <20031212112636.GA12727@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312121433.14603.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     2. Keep track of when devices are used, and when they are not busy.
>        We already have this, it's the module reference count.

USB modules (eg: xxxx-hcd) are typically set up so they can be unloaded at any
time: the act of unloading disconnects any devices driven by the module and
frees resources.  I guess this is problematic for your point 2.  I understand
that some network modules work this way too.

All the best,

Duncan.
