Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTDQOA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbTDQOA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:00:58 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32454
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261404AbTDQOA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:00:58 -0400
Subject: Re: ac97, alc101+kt8235 sound
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Rutherford <mark@justirc.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E9DFEA5.F3F22E79@justirc.net>
References: <Pine.LNX.4.44.0304150537330.28926-100000@q.dyndns.org>
	 <1050406611.27745.34.camel@dhcp22.swansea.linux.org.uk>
	 <3E9DFEA5.F3F22E79@justirc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050585280.31412.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 14:14:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 02:08, Mark Rutherford wrote:
> 2. it would work, but more than 1 application accessing the sound would cause
> the kernel or give it up and once again, lock up.

The lockup reports are not something I've seen before. As to multiple
applications - use ALSA, the OSS driver doesn't currently support the
secondary directsound channels.

I'll try and duplicate the multiple app hangs but I've not seen those
reported so far.

