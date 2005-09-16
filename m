Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbVIPHOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbVIPHOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbVIPHOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:14:03 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:65190 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1161090AbVIPHOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:14:01 -0400
Message-ID: <432A7051.50104@cs.aau.dk>
Date: Fri, 16 Sep 2005 09:12:17 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Automatic Configuration of a Kernel
References: <20050915095658.68775.qmail@web51005.mail.yahoo.com> <200509161303.03955.chriswhite@gentoo.org>
In-Reply-To: <200509161303.03955.chriswhite@gentoo.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris White wrote:
> 
> Couldn't one pull up info from /etc/fstab for filesystems?  And if it was 
> network mounts, the appropriate configuration file?  I wonder how viable that 
> would be.  As far as network protocols, who knows...

I guess the /etc/mtab is more trustable. But, you not anymore speaking
about hardware detection here... I think that everything which is beyond
hardware detection is purely magic and shouldn't be trusted because for
one type of detection if it fit few users, it won't fit many.

And anyway, in the case you are considering, make oldconfig is probably
the one to use.

Regards
-- 
Emmanuel Fleury

I think there is a world market for maybe five computers.
  -- Thomas Watson, chairman of IBM, 1943
