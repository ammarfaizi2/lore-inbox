Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbTLINzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbTLINzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:55:50 -0500
Received: from mhub-c6.tc.umn.edu ([160.94.128.36]:61918 "EHLO
	mhub-c6.tc.umn.edu") by vger.kernel.org with ESMTP id S265849AbTLINzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:55:43 -0500
Subject: Re: State of devfs in 2.6?
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3FD59CED.6090408@portrix.net>
References: <200312081536.26022.andrew@walrond.org>
	 <20031208154256.GV19856@holomorphy.com>
	 <pan.2003.12.08.23.04.07.111640@dungeon.inka.de>
	 <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron>
	 <20031209083228.GC1698@kroah.com>  <3FD59CED.6090408@portrix.net>
Content-Type: text/plain
Message-Id: <1070978097.1092.8.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 07:54:57 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 03:59, Jan Dittmer wrote:
>
> Btw. I still haven't figured out, how to use udev properly. I just get
> the nodes of devices I plugin after boot and of the modules I load after
> boot. IDE et all aren't showing up. How early do I need to load udev or
> has my kernel to be all modular for it to work properly?

Since, I believe, version 006, udev has shipped with an init script
contributed by rml that will create device nodes for devices present
at system boot. You should be able to just make sure that that runs
during your boot sequence and be fine. (I just ran this script on
my system, and made sure it proper nodes for all my IDE drives and
the partitions contained thereon.)

Matt

