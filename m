Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269522AbUINSMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269522AbUINSMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269663AbUINSJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:09:40 -0400
Received: from host-81-191-110-70.bluecom.no ([81.191.110.70]:50316 "EHLO
	mail.blenning.no") by vger.kernel.org with ESMTP id S269627AbUINR6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:58:50 -0400
Subject: Re: /proc/config reducing kernel image size
From: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409141444.02624.norberto+linux-kernel@bensa.ath.cx>
References: <1095179606.11939.22.camel@host-81-191-110-70.bluecom.no>
	 <200409141444.02624.norberto+linux-kernel@bensa.ath.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095184644.1838.11.camel@host-81-191-110-70.bluecom.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 19:57:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 19:44, Norberto Bensa wrote:
> Tom Fredrik Blenning Klaussen wrote:
> > There is no point in storing all the comments and unused options in the
> 
> Try this:
> 
>     mv .config .config-saveme
>     grep -v ^# .config-saveme  > .config
>     make oldconfig
>
> Do you get the exact same kernel (hint: diff .config .config-saveme) ?

You're right.
Am I correct when I say that when an option is not present, it assumes
it's default?

Sincerely
-- 
BFG
