Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUIVX6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUIVX6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268118AbUIVX6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:58:46 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:38065
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268115AbUIVX6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:58:45 -0400
Message-ID: <415211A8.8040907@ppp0.net>
Date: Thu, 23 Sep 2004 01:58:32 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Aubin <daubin@actuality-systems.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com>
In-Reply-To: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Aubin wrote:
> Hi,
> 
>   I know very little about hotplug, but does make sense.
> How do you motivate a hotplug insertion event?  Or should
> I just go read the /docs on hotplugging?  Any help is
> Appreciated:)

There is a "fake" hotplug driver which works for normal pci. But last
time I looked at it, it did only support hot disabling, not hot enabling
- but this surely can be fixed.

Thanks,

Jan
