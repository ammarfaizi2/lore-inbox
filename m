Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313413AbSC2JHv>; Fri, 29 Mar 2002 04:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313412AbSC2JHl>; Fri, 29 Mar 2002 04:07:41 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:35341 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313413AbSC2JHa>;
	Fri, 29 Mar 2002 04:07:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dragon_at_Work <m_giggey@BeansYou.co.jp>
Cc: Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: strange problem with 'make modules_install' -2.4.17, 2.4.18 
In-Reply-To: Your message of "Fri, 29 Mar 2002 14:59:55 +0900."
             <3CA402DB.8050408@BeansYou.co.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Mar 2002 20:07:15 +1100
Message-ID: <29324.1017392835@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 14:59:55 +0900, 
Dragon_at_Work <m_giggey@BeansYou.co.jp> wrote:
>Using RH7.2 and trying to upgrade the Kernel.
>
>other makes seem to work fine (mrproper, menuconfig, dep, clean, 
>bzImage, modules).
>But, when I 'make modules_install', it seems to prematurely abort the 
>process.
>...
>cd /lib/modules/2.4.18; \
>mkdir -p pcmcia; \
>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18; fi

Nothing wrong with that, it is a standard modules_install.

