Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUIGQw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUIGQw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUIGQtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:49:50 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:55475 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S268157AbUIGQrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:47:10 -0400
Date: Tue, 7 Sep 2004 18:47:06 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: James Morris <jmorris@redhat.com>
Cc: Greg KH <greg@kroah.com>, Andreas Happe <andreashappe@flatline.ath.cx>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
In-Reply-To: <Xine.LNX.4.44.0409071236050.26033-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0409071845101.19015@maxipes.logix.cz>
References: <Xine.LNX.4.44.0409071236050.26033-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004, James Morris wrote:

> On Sun, 5 Sep 2004, Greg KH wrote:
>
> > Other than that, I like this move, /proc/crypto isn't the best thing to
> > have in a proc filesystem :)
>
> The only issue is what to do about potentially expanding this into an API
> (e.g. open() an algorithm and write to it).  Does this sort of thing
> belong in sysfs?

I already proposed to have a 'cryptoapifs' mounted e.g. under
/dev/cryptoapi with the "active" entrypoints while /sys would only hold
the "status" of the cryptoapi. Would this be a better approach?

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
