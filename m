Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUCCIFt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 03:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbUCCIFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 03:05:49 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:30914 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262415AbUCCIFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 03:05:43 -0500
Subject: Re: Does the block layer prevent races between open() and
	unregister()?
From: "Yury V. Umanets" <umka@namesys.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0402272302570.4063-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0402272302570.4063-100000@netrider.rowland.org>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1078301208.3493.8.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 10:06:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 06:05, Alan Stern wrote:
> A classic race that all drivers for hot-unpluggable devices have to deal 
> with is the race between open() and unregister() (or disconnect()).
> 
> Does the block layer have any mechanism to prevent such races?  Or does it 
> rely on the lower-level drivers handling such things by themselves?
According to usb-skel driver, nobody cares about.

> 
> Alan Stern
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
umka

