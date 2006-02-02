Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWBBWAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWBBWAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWBBWAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:00:10 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1546 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932326AbWBBWAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:00:08 -0500
Message-ID: <43E280D9.7050803@shadowen.org>
Date: Thu, 02 Feb 2006 21:59:53 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xquad_portio fix declaration missmatch
References: <20060202004306.GA32466@shadowen.org> <20060202172609.GA4231@mipter.zuzino.mipt.ru> <43E27A2E.9020000@shadowen.org>
In-Reply-To: <43E27A2E.9020000@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:

> Indeed it does feel like it should be a numaq special in the numaq
> specific files.  I'll spin that and test it and see if there is a reason
> why its _not_ like that already.

Ok.  It seems pretty clear when you look at it.  The io commands are
used out of the minimal header generated to unzip a compressed kernel image.

-apw

