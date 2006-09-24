Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWIXIz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWIXIz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 04:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWIXIz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 04:55:28 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:27311 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751672AbWIXIz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 04:55:27 -0400
Date: Sun, 24 Sep 2006 11:00:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make kernel -dirty naming optional
Message-ID: <20060924090043.GA22731@uranus.ravnborg.org>
References: <20060922120210.GA957@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922120210.GA957@slug>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:02:10PM +0000, Frederik Deweerdt wrote:
> Hi Sam,
> 
> Could you consider applying this patch (or indicate me a better way to
> do it). It can be handy to be able to keep the naming independent of
> git.
make menuconfig
General setup |
	Automatically append version information ...

is used to control if you append such info or not.
That should solve it for your case.

	Sam
