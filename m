Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTLTK30 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 05:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTLTK30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 05:29:26 -0500
Received: from 50.69-93-3.reverse.theplanet.com ([69.93.3.50]:58523 "EHLO
	spring.persianhosted.com") by vger.kernel.org with ESMTP
	id S263866AbTLTK3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 05:29:25 -0500
From: Armin <Zoup@zoup.org>
Organization: Zoup
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: FrameBuffer Problem With 2.6.0
Date: Sat, 20 Dec 2003 13:54:25 -0900
User-Agent: KMail/1.5.4
References: <2CA1166592F@vcnet.vc.cvut.cz>
In-Reply-To: <2CA1166592F@vcnet.vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312201354.25476.Zoup@zoup.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - spring.persianhosted.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zoup.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 December 2003 03:29, Petr Vandrovec wrote:
> I'm not aware about any problems with matroxfb driver in Linus kernel
> except that you should use 'video=matroxfb:nopan' to avoid problems
> with default resolution XXXx65536 (or clip vyres yourself to reasonable
> value). Of course all 2.6.x fbdev limits apply also to matroxfb driver.
> If you want interface compatible with 2.4.x, you'll have to get patch
> from ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.6.0.gz
> (only vgacon, matroxfb and vesafb are tested).
>


Just enable VesaFB and set vga to 791 , without compiling anything else , now 
frame buffer are working perfectly :)

thanks everyone who helped ;) 

-- 
Kissing a fish is like smoking a bicycle.

