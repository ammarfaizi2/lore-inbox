Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277173AbRJDRGA>; Thu, 4 Oct 2001 13:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277161AbRJDRFt>; Thu, 4 Oct 2001 13:05:49 -0400
Received: from www.transvirtual.com ([206.14.214.140]:32519 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S277173AbRJDRFj>; Thu, 4 Oct 2001 13:05:39 -0400
Date: Thu, 4 Oct 2001 10:06:01 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Josh Myer <jbm@joshisanerd.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB Event Daemon?
In-Reply-To: <Pine.LNX.4.21.0110040158530.31009-100000@dignity.joshisanerd.com>
Message-ID: <Pine.LNX.4.10.10110041004540.32009-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there, or if there were, would it be used, a method to notify a
> user-space daemon/program of USB device insertions? A quick search through
> archives didn't show anything.

Do a open on /proc/bus/usb/devices. Do a select on it. When a device is
attached detached select will return. Then read data from /proc/bus/usb/devices.

