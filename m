Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269265AbUISQba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269265AbUISQba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269270AbUISQba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:31:30 -0400
Received: from [81.23.229.73] ([81.23.229.73]:3564 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S269265AbUISQbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:31:16 -0400
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: plt@taylorassociate.com
Subject: Re:
Date: Sun, 19 Sep 2004 18:31:12 +0200
User-Agent: KMail/1.6.2
References: <1095596968.414d7ba88efc1@webmail.taylorassociate.com> <200409191508.33537.Norbert@edusupport.nl> <1095607945.414da6891fc94@webmail.taylorassociate.com>
In-Reply-To: <1095607945.414da6891fc94@webmail.taylorassociate.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409191831.12034.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assumption:
You are doing "make modules_install"
You are installing a new version of the kernel, not a recompile of the 
currenct kernel.

Is the basic directory in /lib/modules/2.6.8 present for the modules to 
install in?


On Sunday 19 September 2004 17:32, you wrote:
> I am compiling the newest kernel on Redhat Federo 2 and and I am getting
> this error when I am running make modules install.  Do you know how I fix
> this problems please?
>
> Phillip Taylor
>
> INSTALL sound/pci/ymfpci/snd-ymfpci.ko
>   INSTALL sound/pcmcia/pdaudiocf/snd-pdaudiocf.ko
>   INSTALL sound/soundcore.ko
>   INSTALL sound/synth/emux/snd-emux-synth.ko
>   INSTALL sound/synth/snd-util-mem.ko
>   INSTALL sound/usb/snd-usb-audio.ko
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.8; fi
> make: *** [_modinst_post] Error 143
> You have new mail in /var/spool/mail/root
> [root@localhost linux-2.6.8]#
>
> Quoting Norbert van Nobelen <Norbert@edusupport.nl>:
> > Warnings are not errors.
> >
> > On Sunday 19 September 2004 14:29, you wrote:
> > > Question: Are you guys going to work on please cleaning up some of the
> > > errors in the code so we can get please get a more clean compile?
> > >
> > >
> > >
> > > drivers/mtd/nftlmount.c:44: warning: unused variable `oob'
> > >
> > > ----------------------------------------------------------------
> > > This message was sent using IMP, the Internet Messaging Program.
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
>
> ----------------------------------------------------------------
> This message was sent using IMP, the Internet Messaging Program.
