Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281153AbRKYWJu>; Sun, 25 Nov 2001 17:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281155AbRKYWJl>; Sun, 25 Nov 2001 17:09:41 -0500
Received: from weta.f00f.org ([203.167.249.89]:6553 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S281153AbRKYWJ2>;
	Sun, 25 Nov 2001 17:09:28 -0500
Date: Mon, 26 Nov 2001 11:11:05 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
Message-ID: <20011126111105.B10622@weta.f00f.org>
In-Reply-To: <3BFFE8A2.1010708@rueb.com> <Pine.LNX.4.10.10111241402420.3696-100000@coffee.psychology.mcmaster.ca> <20011125222313.D9672@weta.f00f.org> <00e001c175fa$90d02b40$6caaa8c0@kevin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e001c175fa$90d02b40$6caaa8c0@kevin>
User-Agent: Mutt/1.3.23i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 02:45:57PM -0700, Kevin P. Fleming wrote:

    I think if you have a large mail server and zero power protection,
    you've got much larger problems to worry about than write-behind
    caching on your disk drives... my servers have never (in my
    memory) experienced a catastrophic power failure, because they're
    too easy to avoid.

In the specific case of email; you want to make certain guarantees,
and having data written to non-volatile storage is one of them.

As for power-failures, given enough time and enough hardware you will
get them, even if your machines are dual or triple powered of diverse
UPSs or -48V powered; it still is possible and _will eventually
happen_ that something further down the line like the motherboard will
fry or whatever.

People who assume that a small-window is small enough and decide that
is 'good enough' are dangerous :)



   --cw
