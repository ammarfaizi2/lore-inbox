Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUHaVGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUHaVGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268987AbUHaVCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:02:30 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:9094
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267650AbUHaU6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:58:24 -0400
Date: Tue, 31 Aug 2004 13:58:05 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, perex@suse.de
Subject: Re: ALSA update broke Sparc
Message-Id: <20040831135805.371c5c33.davem@davemloft.net>
In-Reply-To: <s5heklnyvmg.wl@alsa2.suse.de>
References: <20040827183646.1da2befc.davem@davemloft.net>
	<s5h4qmkkjl5.wl@alsa2.suse.de>
	<s5heklnyvmg.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also, please do not use __i386__ et al. ifdefs, use
things like CONFIG_I386 and CONFIG_SPARC which are
meant for this purpose.
