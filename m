Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264010AbUDVTu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbUDVTu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUDVTuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:50:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3535 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264647AbUDVTuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:50:11 -0400
Date: Tue, 20 Apr 2004 15:50:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, alsa-user@lists.sourceforge.net,
       alsa-devel@lists.sourceforge.net
Subject: Re: patch to make suspend/resume work
Message-ID: <20040420135011.GA1413@openzaurus.ucw.cz>
References: <20040418055415.8FE2077A2B@mail.lmc.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040418055415.8FE2077A2B@mail.lmc.cs.sunysb.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It seems that pci config space is messed up after resume for Intel
> ICH4 audio controller (on Dell Latitude D600, but I notice that others
> also complain about this problem). Consequently resume from S3 causes
> oops with snd_intel8x0 module. If the module is removed before suspend
> and loaded afterwards, I still get oops. The following simple patch
> fixes the problem. With this, I can leave alsa untouched during
> suspend/resume.
> 


Looks good to me. Probably more drivers need this...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

