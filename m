Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSG3VEe>; Tue, 30 Jul 2002 17:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSG3VEe>; Tue, 30 Jul 2002 17:04:34 -0400
Received: from relay1.pair.com ([209.68.1.20]:41487 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S316548AbSG3VEd>;
	Tue, 30 Jul 2002 17:04:33 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D470124.E9691D07@kegel.com>
Date: Tue, 30 Jul 2002 14:12:04 -0700
From: dank@kegel.com
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: SIGIO for pipes, please...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've grown fond of using pipes as a way
to break out of select loops, but that doesn't work
with SIGIO yet in 2.4.  A nice patch was posted a year ago,
and again a few months ago; you can pick it up here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101772451329517&w=2

It's in 2.5 already.
It'd really be nice if this were integrated into the 2.4 kernel.
Any reason not to do it for 2.4.20?

Without this, my nifty Poller library that makes SIGIO 
usable is kinda broken (the wakeUp function relies on
writing a byte to a pipe). 

Thanks,
Dan
