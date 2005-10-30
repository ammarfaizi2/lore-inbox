Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVJ3Nx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVJ3Nx4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 08:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVJ3Nx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 08:53:56 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:53929 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750876AbVJ3Nx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 08:53:56 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Sun, 30 Oct 2005 13:53:55 +0000
User-Agent: KMail/1.8.92
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>
References: <20051030105118.GW4180@stusta.de> <200510300841.06485.gene.heskett@verizon.net>
In-Reply-To: <200510300841.06485.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301353.55113.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 13:41, Gene Heskett wrote:
> On Sunday 30 October 2005 05:51, Adrian Bunk wrote:
> >This patch schedules obsolete OSS drivers (with ALSA drivers that
> > support the same hardware) for removal.
> >
> >Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.
>
> Isn't this a bit premature?  There are quite a few old mobo's with this
> chipset still in use, like my firewall box.

Gene, if you read the discussion regarding OSS, Adrian plans simply to remove 
drivers which have solid, known working replacements for all PCI ids in an 
equivalent ALSA driver.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
