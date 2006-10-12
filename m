Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWJLULX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWJLULX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWJLULX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:11:23 -0400
Received: from rosi.naasa.net ([212.8.0.13]:37506 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S1750998AbWJLULW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:11:22 -0400
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Userspace process may be able to DoS kernel
Date: Thu, 12 Oct 2006 22:11:14 +0200
User-Agent: KMail/1.9.5
Cc: "=?iso-8859-1?q?G=FCnther?= Starnberger" <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com> <200610121341.56325.lists@naasa.net> <84144f020610120457g221b8736vebf2f0a634480c05@mail.gmail.com>
In-Reply-To: <84144f020610120457g221b8736vebf2f0a634480c05@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610122211.16202.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. Oktober 2006 13:57 schrieb Pekka Enberg:
> If that is the case, you can do git bisect to help us narrow down the
> cause. See
> http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bis
>ect.txt for further details.

Not that easy, since it takes a few hours to be able to trigger the bug. I 
tried to record the system calls with strace but without success. Skype did 
not cause any lockups and then crashes... Maybe the timing is too different 
with strace.

regards,
Jörg
