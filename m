Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVC3PeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVC3PeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVC3PeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:34:09 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:38486 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262246AbVC3PeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:34:06 -0500
Message-ID: <424AC6EA.9040707@tls.msk.ru>
Date: Wed, 30 Mar 2005 19:34:02 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yves Crespin <crespin.quartz@wanadoo.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disable cache disk
References: <424AA2F0.3090100@wanadoo.fr>
In-Reply-To: <424AA2F0.3090100@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yves Crespin wrote:
> Hello,
> 
> I write a lot of files on a USB disk for video monitoring archiving.
> The write program is faster than the USB.
> Cache disk take all RAM and kernel start swapping and everything become 
> very slow.
> 1/ is-it possible to *really* be synchronize. I prefer to have a blocked 
> write() than use cache and get swap!
> 2/ is-it possible to disable cache disk ?

Try open() with O_DIRECT flag for a start.

/mjt
