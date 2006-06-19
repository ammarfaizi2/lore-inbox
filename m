Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWFSPrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWFSPrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWFSPry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:47:54 -0400
Received: from iona.labri.fr ([147.210.8.143]:26310 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932497AbWFSPrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:47:53 -0400
Date: Mon, 19 Jun 2006 17:47:46 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060619154746.GS4253@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <Pine.LNX.4.61.0606191407150.31576@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0606191407150.31576@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt, le Mon 19 Jun 2006 14:08:28 +0200, a écrit :
> >Hi,
> >
> >There's a long-standing issue in init=/bin/sh mode: pressing control-C
> >doesn't send a SIGINT to programs running on the console. The incurred
> >typical pitfall is if one runs ping without a -c option... no way to
> >stop it!
> 
> Worse, I can observe same behavior when using "-b", i.e. init=/sbin/init 
> called with -b (read: `/sbin/init -b`),

That's equivalent to the "emergency" mode.

Samuel
