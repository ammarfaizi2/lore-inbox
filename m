Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265066AbUAOLdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbUAOLdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:33:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19172 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266474AbUAOLcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:32:50 -0500
Date: Thu, 15 Jan 2004 12:32:44 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Message-ID: <20040115113244.GP23383@fs.tum.de>
References: <20040109014003.3d925e54.akpm@osdl.org> <20040109233714.GL1440@fs.tum.de> <3FFF79E5.5010401@winischhofer.net> <20040113190443.GR9677@fs.tum.de> <40048EB4.9010500@winischhofer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40048EB4.9010500@winischhofer.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 01:35:00AM +0100, Thomas Winischhofer wrote:
> >
> >Until the framebuffer stuff in 2.6 gets updated, I'm suggesting the 
> >patch below to mark FB_SIS as BROKEN.
> 
> I think that's a bit harsh. It basically works, it just illegally uses 
> some FP operations (as it still does in 2.4 until Marcelo finally 
> applies the patch I have sent him for three times now - hint, hint)

Now that -mm uses -msoft-float, this means that FB_SIS does no longer 
compile...

> Thomas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

