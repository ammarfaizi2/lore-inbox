Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWBGSrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWBGSrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWBGSrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:47:12 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:41433
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964889AbWBGSrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:47:12 -0500
Subject: Re: [PATCH] new tty buffering locking fix
From: Paul Fulghum <paulkf@microgate.com>
To: Olaf Hering <olh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060207171111.GA15912@suse.de>
References: <200602032312.k13NCbWb012991@hera.kernel.org>
	 <20060207123450.GA854@suse.de>
	 <1139329302.3019.14.camel@amdx2.microgate.com>
	 <20060207171111.GA15912@suse.de>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 12:47:01 -0600
Message-Id: <1139338021.3019.23.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 18:11 +0100, Olaf Hering wrote:
>  On Tue, Feb 07, Paul Fulghum wrote:
> 
> > Try the below patches (for testing only, I'm not suggesting
> > these as a final fix yet) and let me know if it fixes it.
> 
> Yes, this works for me.

OK, good.

I'm working on a change to the locking patch that
fixes this without modifying individual drivers
such as hvc_console. I'll post something later today.

-- 
Paul Fulghum
Microgate Systems, Ltd

