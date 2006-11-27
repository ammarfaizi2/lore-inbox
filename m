Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758535AbWK0TyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758535AbWK0TyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758424AbWK0TyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:54:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54478 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758535AbWK0TyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:54:08 -0500
Date: Mon, 27 Nov 2006 19:59:40 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: avl@logic.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
Message-ID: <20061127195940.1b90a897@localhost.localdomain>
In-Reply-To: <20061127182943.GE2352@gamma.logic.tuwien.ac.at>
References: <20061121115117.GU6851@gamma.logic.tuwien.ac.at>
	<20061121120614.06073ce8@localhost.localdomain>
	<20061122105735.GV6851@gamma.logic.tuwien.ac.at>
	<20061123170557.GY6851@gamma.logic.tuwien.ac.at>
	<20061127130953.GA2352@gamma.logic.tuwien.ac.at>
	<20061127133044.28b8b4ed@localhost.localdomain>
	<20061127160144.GB2352@gamma.logic.tuwien.ac.at>
	<20061127163328.3f1c12eb@localhost.localdomain>
	<20061127175647.GD2352@gamma.logic.tuwien.ac.at>
	<20061127181033.58e72d9a@localhost.localdomain>
	<20061127182943.GE2352@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> size remains still constant, and the exceeding damaged sectors are 
> auto-"hidden" by the drive by means of HPA.
> 
> Still incorrect?

Still incorrect. HPA has nothing to do with damaged sectors. The damaged
sectors are replaced from a pool of sectors that are reserved for this
purpose.
 
Alan
