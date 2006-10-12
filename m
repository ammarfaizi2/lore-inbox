Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161565AbWJLKyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161565AbWJLKyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 06:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWJLKyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 06:54:11 -0400
Received: from rosi.naasa.net ([212.8.0.13]:13767 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S1751259AbWJLKyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 06:54:09 -0400
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Userspace process may be able to DoS kernel
Date: Thu, 12 Oct 2006 12:54:06 +0200
User-Agent: KMail/1.9.5
Cc: =?iso-8859-1?q?G=FCnther_Starnberger?= <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com> <200610120802.59077.lists@naasa.net> <20061012064914.GF5050@1wt.eu>
In-Reply-To: <20061012064914.GF5050@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610121254.06476.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. Oktober 2006 08:49 schrieb Willy Tarreau:
> On Thu, Oct 12, 2006 at 08:02:58AM +0200, Joerg Platte wrote:
> > Using 2.6.18 does not solve the problem. I can see exactly the same
> > behavior with a vanilla and not tainted 2.6.18 kernel.
>
> Just out of curiosity, does the system still respond to ping during this
> period, and does the time still progress during the lock up ? Not that it
> could help me find out what's happening, but it might help troubleshooting
> the problem.

Pinging the system works and the the time is still correct. But this time I 
was not able to trigger a kernel warning, because I was not able to generate 
a long lockup. Maybe I'll have to wait a few more hours before trying it 
again, because the duration of the lockup is proportional to the time skype 
is running.

regards,
Jörg
