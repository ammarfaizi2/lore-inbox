Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTDQXNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbTDQXNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:13:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35785
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262687AbTDQXNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:13:07 -0400
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050618406.32652.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 23:26:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-18 at 00:16, Bartlomiej Zolnierkiewicz wrote:
> Hey,
> 
> This time 5 incremental patches:
> 
> 1       - Fix PIO handlers for Taskfile ioctls.
> 2a + 2b - Taskfile and flagged Taskfile PIO handlers unification.
> 3       - Map HDIO_DRIVE_CMD ioctl onto taskfile.
> 4       - Remove dead ide_diag_taskfile() code.
> 
> [ More comments inside patches. ]

I'll take a look at them for ac3. Can I roll in 1/2a-b and 4 and skip
the experimental one for ac3 ?

