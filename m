Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268932AbTBSPXe>; Wed, 19 Feb 2003 10:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268933AbTBSPXe>; Wed, 19 Feb 2003 10:23:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51473 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268932AbTBSPXd>;
	Wed, 19 Feb 2003 10:23:33 -0500
Date: Wed, 19 Feb 2003 16:33:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arador <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: buggy include path?
Message-ID: <20030219153335.GB970@mars.ravnborg.org>
Mail-Followup-To: Arador <diegocg@teleline.es>,
	linux-kernel@vger.kernel.org
References: <20030219002938.08b717c7.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219002938.08b717c7.diegocg@teleline.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 12:29:38AM +0100, Arador wrote:
> Including include/usb.h from a external module source (out of the kernel tree) causes 
> this:
> In file included from /home/diego/kernel/unsta/include/linux/irq.h:19,
>                  from /home/diego/kernel/unsta/include/asm/hardirq.h:6,
>                  from /home/diego/kernel/unsta/include/linux/interrupt.h:9,
>                  from /home/diego/kernel/unsta/include/linux/usb.h:15, <- file included
>                  from w9968cf.h:38,
>                  from w9968cf.c:57:
> /home/diego/kernel/unsta/include/asm/irq.h:16:25: irq_vectors.h: No such file or directory
> 

Follow Documentations/modules.txt when compiling modules outside the
kernel tree.
That will fix it.

	Sam
