Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUBFSsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUBFSsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:48:53 -0500
Received: from chiapa.terra.com.br ([200.154.55.224]:61100 "EHLO
	chiapa.terra.com.br") by vger.kernel.org with ESMTP id S265683AbUBFSsd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:48:33 -0500
Date: Fri,  6 Feb 2004 15:48:24 -0300
Message-Id: <HSOEWO$7C844976F840E6CB6B3C3C4530825AF6@terra.com.br>
Subject: =?iso-8859-1?Q?Re:[PATCH]_PSX_support_in_input/joystick/gamecon.c?=
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "=?iso-8859-1?Q?iuri.f?=" <iuri.f@terra.com.br>
To: "=?iso-8859-1?Q?pnelson?=" <pnelson@andrew.cmu.edu>
Cc: "=?iso-8859-1?Q?linux-kernel?=" <linux-kernel@vger.kernel.org>
Cc: "=?iso-8859-1?Q?vojtech?=" <vojtech@suse.cz>
Cc: "=?iso-8859-1?Q?linux-joystick?=" 
	<linux-joystick@atrey.karlin.mff.cuni.cz>
X-XaM3-API-Version: 3.2 R28 (B53 pl3)
X-type: 0
X-SenderIP: 200.96.80.24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks nice, any chance of a 2.4.22+ kernel patch? 
 
---------- Cabeçalho inicial  ----------- 
 
De: owner-linux-joystick@atrey.karlin.mff.cuni.cz 
Para: linux-kernel@vger.kernel.org, 
vojtech@suse.cz,linux-joystick@atrey.karlin.mff.cuni.cz 
Cópia:  
Data: Fri, 06 Feb 2004 13:06:49 -0500 
Assunto: [PATCH] PSX support in input/joystick/gamecon.c 
 
> Hi, this is my first kernel hack but it's fairly straight froward.  
I  
> did a partial-rewrite of the PSX support in gamecon.c to make it 
far  
> more usable.  What this patch changes: 
>  
>    * Adds support for more than one controller.  Previously more 
than 
>      one controller was initialized and the docs said they worked, 
but 
>      only one was actually read. 
>    * Removes unnecessary detection on initialization.  This allows 
the 
>      module to be initialized without controllers plugged in (hot 
>      swapping controllers works).  This removes a warning if the 
user 
>      has an unrecognized controller plugged in, but the only 
>      unrecognized controller I have been able to find information 
about 
>      online is the PSX mouse, which I've never actually seen. 
>    * Adds a gc_psx_ddr option to have direction presses register 
as 
>      buttons instead of axes.  Allows the module to be used for 
Dance 
>      Dance Revolution emulators like Stepmania. 
>    * Adds gc_psx_* to documentation. 
>  
> I've tested this with a dualshock 2, clone digital controller, and 
DDR  
> pads.  The patch applies against both 2.6.1 and 2.6.2. 
>  
> -Peter Nelson 
>  

