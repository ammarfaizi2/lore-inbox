Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUGBPNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUGBPNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUGBPNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:13:16 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:52145 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S264637AbUGBPNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:13:15 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Fri, 2 Jul 2004 17:10:58 +0200
User-Agent: KMail/1.6
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040701135425.12104.qmail@web81305.mail.yahoo.com>
In-Reply-To: <20040701135425.12104.qmail@web81305.mail.yahoo.com>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407021710.58152.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 02 Jul 2004 15:11:02.0710 (UTC) FILETIME=[CA0DDD60:01C46046]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. Juli 2004 15.54 schrieb Dmitry Torokhov unter "RE: Continue: 
psmouse.c - synaptics touchpad driver sync problem":
> I see absolutely nothing wrong in the data stream from your external
> mouse, so... how is it configured in X{Free86|org}? What type is it?

XFree86-4.3.99.902-40


> Does it work in text console (with GPM)? What is your GPM setup?
> Try this - in the text console do:
> gpm -k
> gpm -m /dev/input/mice -t ps2
> Try working the mouse, is it good?

Cool! I get exact the same weird problem!

So the problem of the wild clicking Mouse is *not* limited to X11!!!

That means, it must be the kernel...

Regards
Marc
