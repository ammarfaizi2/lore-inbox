Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbVIOMku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVIOMku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVIOMkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:40:49 -0400
Received: from mail.portrix.net ([212.202.157.208]:11440 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1030282AbVIOMkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:40:49 -0400
Message-ID: <43296BCE.9020700@ppp0.net>
Date: Thu, 15 Sep 2005 14:40:46 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1 load average calculation broken?
References: <43295E30.7030508@ppp0.net>
In-Reply-To: <43295E30.7030508@ppp0.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> Get a steady 2.00 there. I stopped unnecessary processes etc.
> load average seems to be invariant
>
> top - 13:41:32 up  4:44,  2 users,  load average: 2.00, 2.00, 2.00
> Tasks: 108 total,   2 running, 105 sleeping,   0 stopped,   1 zombie
> Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 99.7% id,  0.3% wa,  0.0% hi,  0.0% si

Hmm, reboot to 2.6.14-rc1-git1 cured it. Will see if it happens again.
(btw. it was not invariant but the lower limit was 2 even after stopping
everything but some essential processes (ssh, init, getty))

Jan
