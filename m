Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291013AbSBMMry>; Wed, 13 Feb 2002 07:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291611AbSBMMrn>; Wed, 13 Feb 2002 07:47:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49538 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291013AbSBMMrd>;
	Wed, 13 Feb 2002 07:47:33 -0500
Date: Wed, 13 Feb 2002 04:45:45 -0800 (PST)
Message-Id: <20020213.044545.95505962.davem@redhat.com>
To: dalecki@evision-ventures.com
Cc: jgarzik@mandrakesoft.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C6A5EDB.40908@evision-ventures.com>
In-Reply-To: <3C6A57CE.9010107@evision-ventures.com>
	<3C6A5D79.33C31910@mandrakesoft.com>
	<3C6A5EDB.40908@evision-ventures.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Martin Dalecki <dalecki@evision-ventures.com>
   Date: Wed, 13 Feb 2002 13:40:59 +0100

   Of course I admit that I have taken the easy shoot here. But it wasn't 
   possible
   to me to deduce the proper thing to do by looking at the patches.
   This is the usual way I deal with API changes: Have a look at what has 
   been done
   to the other candidates and do the analogous thing where you need it.
   
The API hasn't changed, it is being enforced.  The PCI DMA api
has existed for years.  Please read Documentation/DMA-mapping.txt
so that you may learn how to properly convert drivers.

   But please just show me a non x86 architecture which is using the 
   i810_audio driver!

Because if all drivers are consistently using the portable interfaces,
people writing new drivers will know exactly what to do.
