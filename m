Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTIOHtC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTIOHtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:49:02 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:27810 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262069AbTIOHs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:48:59 -0400
Subject: Re: logging when SIGSEGV is processed?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alexander.riesen@synopsys.COM
Cc: bert hubert <ahu@ds9a.nl>, Mo McKinlay <lkml@ekto.ekol.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030915070945.GD1091@Synopsys.COM>
References: <20030914111408.GA14514@strawberry.blancmange.org>
	 <20030914171741.GA18627@outpost.ds9a.nl>
	 <20030915070945.GD1091@Synopsys.COM>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063612045.3734.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 08:47:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 08:09, Alex Riesen wrote:
> Probably ptrace the daemon (following all its children) would server better.
> The feature (logging the coredumps) is definitely no needed for
> everything, just some suspectables.

accton() will turn on logging and that gives you log records of process
termination including if it segfaulted.

