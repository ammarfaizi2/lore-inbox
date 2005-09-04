Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVIEQcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVIEQcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIEQcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:32:23 -0400
Received: from [81.2.110.250] ([81.2.110.250]:62357 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932317AbVIEQcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:32:20 -0400
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1EBfWr-0004LP-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1EBfWr-0004LP-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Sep 2005 09:45:31 +0100
Message-Id: <1125823531.23858.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-03 at 23:26 +0200, Bernd Eckenfels wrote:
> Loading a non-GPL (tagged) module leads in tainting the kernel (which basically
> is a flag for developers to be alerted while debugging), is that right?

Correct, although some administrators find it useful too

> Non GPL Modules are also restrited in the number of symbols they can use,
> this is to make it harder to derive work from the Linux Kernel with a ABI
> interface.

Non GPL modules are required not to be derivative works (a term of law).
The EXPORT_SYMBOL information is merely advisory to help seperate
symbols. In many cases its purely historical as to whether a symbol is
marked _GPL or not.

If a work is derivative of another GPL work by any means then the GPL
applies to it. If it is not then the GPL has no power over it because
the GPL is a copyright based license. The law itself circumscribes the
power of such licenses and their reach.

And no doubt German law could be totally different.

Alan

