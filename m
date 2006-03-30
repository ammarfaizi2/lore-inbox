Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWC3IFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWC3IFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWC3IFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:05:11 -0500
Received: from antispam.upcomillas.es ([130.206.70.245]:31701 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S1751321AbWC3IFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:05:09 -0500
Date: Thu, 30 Mar 2006 10:05:51 +0200
From: Romano Giannetti <romanol@upcomillas.es>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: ALPS stop worked between 2.6.13 and 2.6.16
Message-ID: <20060330080551.GA19056@pern.dea.icai.upcomillas.es>
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
References: <20060327153624.GC8679@pern.dea.icai.upcomillas.es> <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com> <20060327190826.GA18193@pern.dea.icai.upcomillas.es> <d120d5000603271112r35ba7100jceb8aaf3e8bf8c70@mail.gmail.com> <20060329164330.GA8977@pern.dea.icai.upcomillas.es> <d120d5000603290855u40c0cc22vac326da31bf5f8aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d120d5000603290855u40c0cc22vac326da31bf5f8aa@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 29, 2006 at 11:55:03AM -0500, Dmitry Torokhov wrote:
> On 3/29/06, Romano Giannetti <romanol@upcomillas.es> wrote:
> >
> > but then nothing happened, no devices etc. So evidently the new udev is
> > unable to cope with the old and maybe buggy Mandriva 2005 configuration[1].
> > I unfortunately have no time to desentangle the dependency mess, so it's
> > time to stop testing new kernels... unless anyone can point me to a "howto".
> >
> 
> I am sorry to hear that. You might want to check on the hotplug list,
> maybe someone there could offer you some guidance. To tell you the
> truth I am still running with static /dev...
> 

Well, if you can hint a "mknod" I can add to my rc scripts to have the ALPS
touchpad working with the old udev, I wouldn't mind sticking it in my
system. I have /dev/psaux created ok, but then it seems that the synapctics
drivers seraches for a /dev/input/event? which do not exists. It is possible
to have a static entry "working everytime" (I mean, booting with/without
external mouse, with/withour external keypad etc.)? If so I paint myself
happy. 

Romano 

PD: totally unrelated. I was toying with the idea of trasforming a IR remote
control in a "keyboard". I think there is a way to create a userspace input
device and then feeding back the "keypresses" to the kernel... can you point
me to more info on this? Thanks!


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/

--
La presente comunicación tiene carácter confidencial y es para el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el destinatario indicado, le informamos que cualquier forma de distribución, reproducción o uso de esta comunicación y/o de la información contenida en la misma están estrictamente prohibidos por la ley. Si Ud. ha recibido esta comunicación por error, por favor, notifíquelo inmediatamente al remitente contestando a este mensaje y proceda a continuación a destruirlo. Gracias por su colaboración.

This communication contains confidential information. It is for the exclusive use of the intended addressee. If you are not the intended addressee, please note that any form of distribution, copying or use of this communication or the information in it is strictly prohibited by law. If you have received this communication in error, please immediately notify the sender by reply e-mail and destroy this message. Thank you for your cooperation. 
