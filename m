Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285792AbRLYUWe>; Tue, 25 Dec 2001 15:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285812AbRLYUWZ>; Tue, 25 Dec 2001 15:22:25 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:13952
	"HELO tabris.net") by vger.kernel.org with SMTP id <S285792AbRLYUWK>;
	Tue, 25 Dec 2001 15:22:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <adam@tabris.net>
Organization: Dome-S-Isle Data
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc2aa1 - blocking(?) in /proc
Date: Tue, 25 Dec 2001 15:22:05 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011219161610.I1395@athlon.random>
In-Reply-To: <20011219161610.I1395@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011225202206.EEBC6FB81B@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I booted into 2.4.17-rc2aa1(compiled w/ gcc-3.0.3), and after an hour of 
uptime or so, was unable to read anything in /proc (top locked, procinfo, and 
I couldn't kill them b/c killall and pidof would lock as well)

I made only one mod. I changed HZ to 1024, but I don't think that should have 
done it.

I figure either a problem in gcc 3.0.3, or a kernel bug.

Ideas?

---
tabris
