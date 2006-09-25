Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWIYLjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWIYLjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWIYLjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:39:07 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:26804 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751427AbWIYLjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:39:05 -0400
Subject: Re: mainline aic94xx firmware woes
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-scsi <linux-scsi@vger.kernel.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1159183984.11049.59.camel@localhost.localdomain>
References: <20060925101124.GH6374@rhun.haifa.ibm.com>
	 <1159183984.11049.59.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 06:38:56 -0500
Message-Id: <1159184336.3463.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 12:33 +0100, Alan Cox wrote:
> We should not be including non-free firmware in the kernel, we should be
> continuing to drive it out into things like initramfs.

Right, which is why this was done as one of the conditions for accepting
the driver

> > Also, aic94xx does not compile unless FW_LOADER is set in .config due
> > to missing 'request_firmware'. What's the right thing to do here -
> > aic94xx selecting it, depending on it
> 
> Either select or depend

select, I think.

James


