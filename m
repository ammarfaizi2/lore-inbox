Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVKCD03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVKCD03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVKCD03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:26:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030294AbVKCD02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:26:28 -0500
Date: Thu, 3 Nov 2005 13:26:14 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 03/37] dvb: stv0299: revert improper method
Message-Id: <20051103132614.4f46bb8f.akpm@osdl.org>
In-Reply-To: <43672368.6080705@m1k.net>
References: <43672368.6080705@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
>  +	if (state->errmode != STATUS_UCBLOCKS) *ucblocks = 0;
>  +	else *ucblocks = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);

Preferred kernel tyle is

	if (expr)
		statement;
	else
		statement;

please.
