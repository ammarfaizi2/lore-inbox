Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbTGHQeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbTGHQeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:34:44 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:49892 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267449AbTGHQei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:34:38 -0400
Date: Tue, 8 Jul 2003 18:51:25 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Vincent Touquet <vincent.touquet@pandora.be>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030708165125.GL14044@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org> <20030708161406.GJ14044@ns.mine.dnsalias.org> <20030708184132.A25510@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708184132.A25510@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 06:41:32PM +0200, Vojtech Pavlik wrote:
>Most likely caused by the slave devices confusing the BIOS cable
>detection. The amd74xx driver can only use what the BIOS tells it. You
>can use 'ide0=ata66' to override the cable detection.

Thanks, that should solve it.

Any idea on what could cause the lockups of my system ?
Some output of vmstat near the hangs, and also stack traces can be found
in this thread: http://marc.theaimsgroup.com/?t=105752570500001&r=1&w=2

best regards,

Vincent
