Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUIOXFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUIOXFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUIOXEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:04:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17052 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267730AbUIOXDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:03:40 -0400
Subject: Re: [PATCH-NEW] allow root to modify raw scsi command permissions
	list
From: Peter Jones <pjones@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095284325.20749.8.camel@localhost.localdomain>
References: <1095173470.5728.3.camel@localhost.localdomain>
	 <20040915230813.6eac1d04.Ballarin.Marc@gmx.de>
	 <1095284325.20749.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 19:03:24 -0400
Message-Id: <1095289404.20046.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 22:38 +0100, Alan Cox wrote:
> On Mer, 2004-09-15 at 22:08, Marc Ballarin wrote:
> > Hi,
> > this is a modified version of the previous patch.
> 
> You need to check for capable(CAP_SYS_RAWIO) otherwise you elevate
> anyone with access bypass capabilities to CAP_SYS_RAWIO equivalent
> powers.

Do you mean in the ->store path?
-- 
        Peter

