Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbSKCKn6>; Sun, 3 Nov 2002 05:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSKCKn6>; Sun, 3 Nov 2002 05:43:58 -0500
Received: from hacksaw.org ([216.41.5.170]:23292 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S261746AbSKCKn5>; Sun, 3 Nov 2002 05:43:57 -0500
Message-Id: <200211031050.gA3AoO2l008421@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: kaih@khms.westfalen.de (Kai Henningsen)
cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6? 
In-reply-to: Your message of "03 Nov 2002 10:59:00 +0200."
             <8$A6Ivu1w-B@khms.westfalen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Nov 2002 05:50:24 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As a sysadmin, this should be about 20 seconds with your favourite editor  
>to create a "setcap" shell script.

Ville Herva pointed out that it'd be modifying in core structures, so maybe it 
is the right thing to do. I do like the idea of every setuid file needing to 
be listed in one place.

I still find "mount --bind --capability=xx,yy /usr/bin/foo /usr/bin/foo" to be 
a strange syntax. It implies that one is mounting /usr/bin/foo over 
/usr/bin/foo, and adding the xx,yy capabilities.


-- 
What we hear is the way that we hear.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


