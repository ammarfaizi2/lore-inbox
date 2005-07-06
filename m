Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVGFXEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVGFXEA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVGFXCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:02:12 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:61078 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261718AbVGFXBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:01:09 -0400
Date: Thu, 7 Jul 2005 03:01:11 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2: PCMCIA problem on AMD64
Message-ID: <20050707030111.A6806@den.park.msu.ru>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <200507061128.49843.rjw@sisk.pl> <20050707014348.A1005@jurassic.park.msu.ru> <200507070015.20373.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200507070015.20373.rjw@sisk.pl>; from rjw@sisk.pl on Thu, Jul 07, 2005 at 12:15:19AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 12:15:19AM +0200, Rafael J. Wysocki wrote:
> > Does the appended one-liner fix that?
> 
> Yes, it does, but I'm still getting these in dmesg:
> 
> PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.0
> PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.1
> PCI: Failed to allocate I/O resource #7:1000@e000 for 0000:02:01.1
> PCI: Failed to allocate I/O resource #8:1000@e000 for 0000:02:01.1

It's OK. Eventually we move such stuff into "debug" level.

Thanks,

Ivan.
