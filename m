Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWAVTI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWAVTI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWAVTI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:08:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53952 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751316AbWAVTI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:08:26 -0500
Subject: Re: soft update vs journaling?
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060122190533.GH10003@stusta.de>
References: <43D3295E.8040702@comcast.net>
	 <Pine.LNX.4.61.0601220945160.5126@yvahk01.tjqt.qr>
	 <20060122190533.GH10003@stusta.de>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 20:08:17 +0100
Message-Id: <1137956898.3328.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 20:05 +0100, Adrian Bunk wrote:
> On Sun, Jan 22, 2006 at 09:51:10AM +0100, Jan Engelhardt wrote:
> >...
> >  - I would not use a journalling filesystem at all on media that degrades
> >    faster as harddisks (flash drives, CD-RWs/DVD-RWs/RAMs).
> >    There are specially-crafted filesystems for that, mostly jffs and udf.
> >...
> 
> [ ] you know what the "j" in "jffs" stands for

it stands for "logging" since jffs2 at least is NOT a journalling
filesystem.... but a logging one. I assume jffs is too.
 

