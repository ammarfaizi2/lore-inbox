Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbUDQJ0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 05:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263757AbUDQJ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 05:26:28 -0400
Received: from piedra.unizar.es ([155.210.11.65]:4078 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S263748AbUDQJ01 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:26:27 -0400
From: "Jorge Bernal (Koke)" <koke_lkml@amedias.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.5] Oversized FB logos
Date: Sat, 17 Apr 2004 11:26:09 +0200
User-Agent: KMail/1.6.1
Cc: Joshua Kwan <joshk@triplehelix.org>
References: <pan.2004.04.17.03.07.22.362894@triplehelix.org>
In-Reply-To: <pan.2004.04.17.03.07.22.362894@triplehelix.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404171126.09188.koke_lkml@amedias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sábado, 17 de Abril de 2004 05:07, Joshua Kwan wrote:
> Hi everyone,
>
> Note that I'd be using bootsplash for this but vesafb only works up to
> 8bit color and bootsplash requires 16bit color.

Maybe I haven't understood your question but I'm using vesafb at 1280x1024 and 
16 bits w/o any problem.

> Are boot logos in any way supported in this fashion? I'm tempted to just
> nuke the emit_log_char call in printk.c, which I think might serve my
> purpose temporarily...
>

what about passing CONSOLE=/dev/tty2 or CONSOLE=/dev/null at boot loader 
command line?? I saw that once in something like bootsplash or lpp but I'm 
not sure if this will work well.

> Any hints/help provided would be highly appreciated. Thanks
