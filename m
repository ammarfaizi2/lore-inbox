Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbUKLTQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUKLTQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKLTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:15:01 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7382 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261601AbUKLTO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:14:57 -0500
Date: Fri, 12 Nov 2004 10:59:05 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [patch 2/2] fakephp: add pci bus rescan ability
Message-ID: <20041112185905.GA311@kroah.com>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com> <41687EBA.7050506@ppp0.net> <41688985.7030607@ppp0.net> <41693CF9.10905@ppp0.net> <20041030041615.GH1584@kroah.com> <41857C7B.3080304@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41857C7B.3080304@ppp0.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 12:59:55AM +0100, Jan Dittmer wrote:
> This adds the ability to rescan the pci bus for newly inserted,
> reprogrammed or previously disabled pci devices.
> To initiate a rescan you need to write '1' to any of the
> /sys/bus/pci/slots/*/power control files. No known pci devices
> will be touched.
> Additionally this fixes a bug, when someone tries to disable
> a device with subfunctions. The subfunctions will be disabled first now.

Very nice, thanks for doing this work.

Applied, thanks.

greg k-h
