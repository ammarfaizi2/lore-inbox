Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbTK3CWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 21:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbTK3CWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 21:22:55 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:48162 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S264596AbTK3CWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 21:22:54 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200311300222.hAU2MqcB002434@green.mif.pg.gda.pl>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
To: linux-kernel@vger.kernel.org (kernel list)
Date: Sun, 30 Nov 2003 03:22:52 +0100 (CET)
Cc: aebr@win.tue.nl
In-Reply-To: <200311300220.hAU2K0dr019280@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Nov 30, 2003 03:20:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The BIOS reads the MBR and jumps to the code loaded from there.
> There is no need for any partition table, or, if there is a table,
> for any particular format. It is all up to the code that is found
> in the MBR.

I found some PC BIOS-es refuse to read the MBR if no active partition is
found in the partition table...

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
