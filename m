Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbTAOPsO>; Wed, 15 Jan 2003 10:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTAOPsO>; Wed, 15 Jan 2003 10:48:14 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:26615 "EHLO
	albatross.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S266675AbTAOPsM>; Wed, 15 Jan 2003 10:48:12 -0500
X-Sybari-Trust: ae8752be 1864f774 206fc897 00000138
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Wed, 15 Jan 2003 16:56:51 +0100 (MET)
Message-Id: <200301151556.h0FFupx12324@duna48.eth.ericsson.se>
To: Padraig@Linux.ie
CC: Larry.Sendlosky@storigen.com, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
In-reply-to: <3E257488.3000006@Linux.ie> (Padraig@Linux.ie)
Subject: Re: VIA C3 and random SIGTRAP or segfault
References: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com> <3E257488.3000006@Linux.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> segfault is what I saw. Something seems to be corrupted (by a cmov
> SIGILL?) and from then the app will crash in the same
> (arbitrary) place until the machine is restarted. Some apps
> are more susceptible than others. Note a Samuel II would work fine?

Do you mean that after a cmov is encountered other applications will
also randomly crash?  That would explain what I've been seeing.

Miklos
