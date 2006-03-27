Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWC0MGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWC0MGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 07:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWC0MGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 07:06:33 -0500
Received: from antispam.upcomillas.es ([130.206.70.245]:38881 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S1750942AbWC0MGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 07:06:32 -0500
Date: Mon, 27 Mar 2006 14:07:06 +0200
From: Romano Giannetti <romanol@upcomillas.es>
To: linux-kernel@vger.kernel.org
Subject: Good news --- jump from 2.6.13-rc3 to 2.6.16  (almost) ok (swsusp, input)
Message-ID: <20060327120706.GA838@pern.dea.icai.upcomillas.es>
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all. 

I finally tried to install 2.6.16 on my portable PC, jumping directly from
2.6.13-rc3, and there are good news. The most critical thing, namely swsusp,
did work ok and seems faster than before. A little problem is that when
starting the suspend, no messages are printed (the screen goes blank and
after a bit the machine poweroff). But then resume is ok . The same goes for
-ck1,  which has a really nice feeling.

The only little problem is with the synaptics ALPS touchpad. It seems that the
"event" interface changes at every reboot, and the method "use device
/dev/psaux" and protocol "auto-dev" does not work. All logs are here:

http://www.dea.icai.upco.es/romano/linux/vaio-conf/config-2.6.16-ck1-after-boot/laptop-config.html

Thanks for the good work, all.

       Romano 

PS: this is probably offtopic, but my laptop started doing a very strange 
thing. When powered off and then rapidly powered on, it stays stuck at the
"Sony" logo page. I have to wait 2 to 3 minutes to have it enters LILO. Any
idea? I lost time too; could the little bios-backup battery be responsible? 
Thanks!

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/

--
La presente comunicación tiene carácter confidencial y es para el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el destinatario indicado, le informamos que cualquier forma de distribución, reproducción o uso de esta comunicación y/o de la información contenida en la misma están estrictamente prohibidos por la ley. Si Ud. ha recibido esta comunicación por error, por favor, notifíquelo inmediatamente al remitente contestando a este mensaje y proceda a continuación a destruirlo. Gracias por su colaboración.

This communication contains confidential information. It is for the exclusive use of the intended addressee. If you are not the intended addressee, please note that any form of distribution, copying or use of this communication or the information in it is strictly prohibited by law. If you have received this communication in error, please immediately notify the sender by reply e-mail and destroy this message. Thank you for your cooperation. 
