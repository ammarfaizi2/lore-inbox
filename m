Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTLNVNp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 16:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTLNVNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 16:13:44 -0500
Received: from mail.cybertrails.com ([162.42.150.35]:24049 "EHLO
	mail10.cybertrails.com") by vger.kernel.org with ESMTP
	id S262580AbTLNVNm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 16:13:42 -0500
Date: Sun, 14 Dec 2003 14:13:04 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Matti =?ISO-8859-1?B?TOVuZ3ZhbGw=?= <matti@ovikonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: USB Mass Storage, cannot mount Flash drives
Message-Id: <20031214141304.5b3a20b2.dickson@permanentmail.com>
In-Reply-To: <1071155473.1666.4.camel@deathstar>
References: <1071155473.1666.4.camel@deathstar>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2003 16:11:12 +0100, Matti Långvall wrote:

> I have for quite some time been unable to mount flash drives, it works
> in  2.4.x
> but not in 2.6.0 testX.
> 
> Some details that needs to be completed with ?

What version of hot-plug are you using?  Is it compatible with 2.6?

I say this because of the "bogus sysfs" messages in the log and a line
about not being able to load a module, the latter meaning either you
haven't compiled the right module or hot-plug is asking for the wrong one.

Hot-plug is not listed in your software versions.  Verify that your
version supports 2.6.

I dimly remember tripping over something like this when I switched to
2.6.0-test2 many months ago.  I grabbed the latest hotplug RPM.

	-Paul

I'm not an expert on usb-storage, this is just from my experiences.

