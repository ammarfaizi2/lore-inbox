Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVBDL2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVBDL2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVBDL2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:28:17 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:42616 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261947AbVBDL2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:28:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gLo4y6ITZ6JyBA4PDTe4/R50u8TcKuxRwrH0BLLLi+2pwvewxPlTlFzCn9DkayHQZByN4b1wxPkaKXebXOxhz0ZxPH7DEDg3tB9f0tWMg78gpXbltzgVo3dvLys3QcEH6xCtxjA7974ajc021NiPiZZmiVm8bjlIa96voUG3pwg=
Message-ID: <5a2cf1f60502040328aaf6c9f@mail.gmail.com>
Date: Fri, 4 Feb 2005 12:28:07 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>
Subject: Re: Huge unreliability - does Linux have something to do with it?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1Cx0xm-0000GD-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5a2cf1f605020401037aa610b9@mail.gmail.com>
	 <E1Cx0xm-0000GD-00@calista.eckenfels.6bone.ka-ip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Could a hardware failure look like bad sectors to fsck?
> 
> A failure of the bus or a former sporadic error can cause defective fs, but
> normally you have a read error in fsck no structure error.
> 
> Are you using hdparm? is the system perhaps overheating or overclocked?

no overclock
hdparm is used but I cannot tell you exactly what the config is (now
machine has been running memtest for 1.5 hour). I don't think I use
special option: probably the defaults in my config file (mult_sect 16,
dma on, write_cache off).

overheating: perhaps. The machine is hot and running many hours per
day (usually 12-16). It s running the fans very often, but it's always
been like that. I've tried to control the fan, but then the
temperature goes high very quickly. So I let the fans run.
