Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUEQWqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUEQWqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUEQWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:44:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24487 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262802AbUEQWjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:39:22 -0400
Message-ID: <40A93F0D.2070200@pobox.com>
Date: Mon, 17 May 2004 18:39:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Picco <Robert.Picco@hp.com>
CC: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com> <40A40204.1060509@pobox.com> <40A93DA5.4020701@hp.com>
In-Reply-To: <40A93DA5.4020701@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Picco wrote:
> O.K.  Did this but had to add a writeq and readq for i386.


Let me be the first to say:  yay!

IMO, readq and writeq are not only needed, but an implementation should 
be added to 2.4.x kernels as well.

The amount of hardware (and thus drivers) that will use 64-bit memory 
IOs can and will increase, as time passes.

	Jeff



