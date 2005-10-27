Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVJ0VCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVJ0VCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVJ0VCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:02:07 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:48564
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932245AbVJ0VCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:02:05 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Date: Thu, 27 Oct 2005 17:02:06 -0400
Message-Id: <20051027205921.M81949@linuxwireless.org>
In-Reply-To: <1130446667.5416.14.camel@blade>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005 22:57:47 +0200, Marcel Holtmann wrote
> Hi Alejandro,
> 
> the board in this system is a Intel D945GNT and the box tells me the
> maximum supported amount of RAM is 4 GB. So there should be a way to
> address this amount memory.

Marcel,

The board did take the 4GB of RAM and it is finding them, therefore supports
them. It is just not designed to give a full 4GB of RAM to the system, it only
gives 3.4XGB RAM and the rest is really not used, then basically the system
just tries to give the 0.6xGB RAM remaining a task by it being used by "System
Resources"

This isn't really Linux dependant.

.Alejandro

> 
> Regards
> 
> Marcel


