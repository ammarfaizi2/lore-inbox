Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUFXJfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUFXJfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUFXJfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:35:48 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:38844 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S264103AbUFXJfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:35:43 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Thu, 24 Jun 2004 11:35:12 +0200
User-Agent: KMail/1.6
Cc: t.hirsch@web.de, laflipas@telefonica.net, linux-kernel@vger.kernel.org
References: <20040623155944.96871.qmail@web81304.mail.yahoo.com>
In-Reply-To: <20040623155944.96871.qmail@web81304.mail.yahoo.com>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406241135.12966.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 24 Jun 2004 09:35:21.0226 (UTC) FILETIME=[917D4EA0:01C459CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 23. Juni 2004 17.59 schrieb Dmitry Torokhov unter "RE: Continue: 
psmouse.c - synaptics touchpad driver sync problem":
> Try passing i8042.nomux to the kernel and try using your touchpad/keyboard.

External mouse does not move anymore. External keyboard still works, so that's 
not the solution...

Well, I can do a long-run test with the internal touchpad/keyboard only, to 
see if at least this works now better. "Unfortunately" the problems with 
internal keyboard/touchpad are less frequent and less reproducible.


> If nomux does not help you may try to use 
> psmouse.proto=bare

No, does not help. :-(


> or psmouse.proto=imps to disable Synaptics-specific 
> extensions.

Well, IMPS seems to be completely incompatible to normal PS/2, so as expected 
things get worse, means now the internal mouse jumps around like crazy.

Please note, that one of the external mice, the one I am actually testing, is 
not a scroll mouse, but a normal PS/2 mouse.

Regards
Marc
