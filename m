Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbTEKRVF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTEKRVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:21:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56212
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261202AbTEKRVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:21:05 -0400
Subject: Re: [PATCH] Switch ide parameters to new-style and make them
	unique.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeremy Jackson <jerj@coplanar.net>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0305111712230.8722-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0305111712230.8722-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052670913.29921.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 17:35:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-11 at 16:32, Bartlomiej Zolnierkiewicz wrote:
> FYI I have just done dynamic ide_hwifs allocations, patch needs
>     finishing (pdc4030 special case), polishing and testing.

Excellent. I killed the other pdc4030 special case in 2.4.21rc2-ac.
I'll push updates for that along once the taskfile stuff is stable
as it requires being able to hook the rw_disk function. HPT372N also
requires this to do the clock switching


