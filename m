Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbTAQRwM>; Fri, 17 Jan 2003 12:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTAQRwM>; Fri, 17 Jan 2003 12:52:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:42764 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267622AbTAQRwL>;
	Fri, 17 Jan 2003 12:52:11 -0500
Date: Fri, 17 Jan 2003 19:00:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Shlomi Fish <shlomif@vipe.technion.ac.il>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
Message-ID: <20030117180001.GA1860@mars.ravnborg.org>
Mail-Followup-To: Shlomi Fish <shlomif@vipe.technion.ac.il>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 07:00:58PM +0200, Shlomi Fish wrote:
> 
> Do you mean I'll need a live Linux kernel to build the kernel module
> package?

Yes, you fundamentally need the full kernel to compile a module.
Modules may refer to different headers, and some may even be arch specific.

The trick dwmw2 gave you is the only _sane_ way to build a module.

	Sam
