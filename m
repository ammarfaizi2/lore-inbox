Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVCNNhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVCNNhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVCNNhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:37:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10913 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261496AbVCNNg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:36:26 -0500
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for
	2.6.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       peterc@gelato.unsw.edu.au
In-Reply-To: <1110575069.1949.72.camel@cube>
References: <1110518308.1949.67.camel@cube>
	 <1110568542.15927.76.camel@localhost.localdomain>
	 <1110575069.1949.72.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110807262.15927.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Mar 2005 13:34:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-11 at 21:04, Albert Cahalan wrote:
> > Still insufficient because the device might be hotplugged on you. You
> > need a file handle that has the expected revocation effects on unplug
> > and refcounts
> 
> I was under the impression that a file handle would be returned.

Then lets use that popular "open" system call

