Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265939AbUGAPik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUGAPik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUGAPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:38:40 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:49984 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S265939AbUGAPij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:38:39 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Thu, 1 Jul 2004 17:38:04 +0200
User-Agent: KMail/1.6
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040630132305.98864.qmail@web81306.mail.yahoo.com> <200407011434.59340.Marc.Waeckerlin@siemens.com> <200407010804.00438.dtor_core@ameritech.net>
In-Reply-To: <200407010804.00438.dtor_core@ameritech.net>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011738.04304.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 01 Jul 2004 15:38:07.0897 (UTC) FILETIME=[6853F890:01C45F81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. Juli 2004 15.03 schrieb Dmitry Torokhov unter "Re: Continue: 
psmouse.c - synaptics touchpad driver sync problem":
> On Thursday 01 July 2004 07:34 am, Marc Waeckerlin wrote:

> I usually feel some hesitation in cursor movement under high disk load -
> do you experience something like that? Although, now that I think about it,
> it's usually not the cursor itself but KDE is lagging to redraw...

No, definitely the cursor. And not only if the HD usage is high, sometimes if 
the CPU load is high, the problem starts, and if CPU and HD usage are low 
again, the problem is still remaining. I cannot really see a clear 
correlation between system load and mouse waiting, but there seems to be some 
sort of weak correlation.


> Just out of curiosity, what happens when you pass psmouse.proto=bare to the
> kernel as a boot option (or put "options psmouse proto=bare" in your
> /etc/modprobe.conf file if psmouse is compiled as a module)?

I'll try later, but what should habben, what should I look for?


Regards
Marc
