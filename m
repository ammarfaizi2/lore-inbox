Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUAGNjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265566AbUAGNjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:39:10 -0500
Received: from [212.28.208.94] ([212.28.208.94]:34568 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265560AbUAGNjG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:39:06 -0500
From: Robin Rosenberg <roro.l@dewire.com>
To: ncunningham@users.sourceforge.net
Subject: Re: udev and devfs - The final word
Date: Wed, 7 Jan 2004 14:39:03 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040103040013.A3100@pclin040.win.tue.nl> <200401051201.58356.roro.l@dewire.com> <1073306368.4181.103.camel@laptop-linux>
In-Reply-To: <1073306368.4181.103.camel@laptop-linux>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401071439.03915.roro.l@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

måndagen den 5 januari 2004 13.39 skrev Nigel Cunningham:
> Hi.
>
> The suspend to disk implementations all assume that devices are not
> [dis]appearing under us while we're suspended. If you do go adding and
> removing devices while the power is off, you can expect the same
> problems you'd get if you removed them without suspending the machine.
> It would be roughly equivalent to hot[un]plugging devices.

Yes. It's very unclear unless you do mind reading, but I had in mind mounted filesystems
such as /home on a USB stick or firewire Reasonable? yes! But such devices have to
be rediscovered and allocated in such a way that the user can resume using the device
as soon as it has been found. And it should not fail miserably if the user forgets to connect
the device before resuming the machine. As you cannot unmount /home (usually) the
kernel must remember the device somehow or make mounting file systems more loosely
than today.

-- robin


