Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUIWQ6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUIWQ6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUIWQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:57:22 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:27306
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268176AbUIWQyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:54:07 -0400
Message-ID: <4152FFA0.9020005@ppp0.net>
Date: Thu, 23 Sep 2004 18:53:52 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <20040923002649.GA28259@kroah.com> <4152E606.3070609@ppp0.net> <200409231849.11597@bilbo.math.uni-mannheim.de>
In-Reply-To: <200409231849.11597@bilbo.math.uni-mannheim.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Just search the archive of pcihpd-discuss@lists.sourceforge.net for dummyphp, 
> this is the version that works. I'll rediff it soon and hope Greg will accept 
> it this time.
> 
> Message-Id to search for: <200403120947.13046@bilbo.math.uni-mannheim.de>

You didn't read my p.s. ... I found it and it's working quite nice. Already
discovered a bug in dv1394. Just one thing: Can you strip DUMMY- from the
name in /sys/bus/pci/slots/ ? It's really ugly and you can't mix different
hotplug drivers anyway.

Thanks,

Jan
