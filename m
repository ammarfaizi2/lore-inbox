Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUAOPkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUAOPkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:40:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:27318 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264392AbUAOPkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:40:09 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Jan 2004 16:20:09 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l-05 add infrared remote support
Message-ID: <20040115152009.GB18322@bytesex.org>
References: <20040115115611.GA16266@bytesex.org> <Pine.LNX.4.58.0401151502320.27223@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401151502320.27223@serv>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another possibility is to use select:
> 
> # selected as needed
> config VIDEO_IR
> 	tristate
> 
> config VIDEO_BT848
> 	...
> 	select VIDEO_IR

I like that one more, but last time I tried it didn't work.
Is support select in Linus tree now?

  Gerd

-- 
You have a new virus in /var/mail/kraxel
