Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbSJCQAM>; Thu, 3 Oct 2002 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbSJCQAM>; Thu, 3 Oct 2002 12:00:12 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:21208 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261755AbSJCQAL>;
	Thu, 3 Oct 2002 12:00:11 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200210031604.UAA29978@sex.inr.ac.ru>
Subject: Re: [PATCH] 2.5.40 - remove IPV6_ADDRFORM
To: davem@redhat.COM (David S. Miller)
Date: Thu, 3 Oct 2002 20:04:03 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021003.054332.22032944.davem@redhat.com> from "David S. Miller" at Oct 3, 2 05:15:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Are we absolutely sure no applications use this?

To my shame I have to recognize: my local inetd/sendmail/ftpd still use it,
despite of all my many years snivels that it is mad-broken-crap-... :-)

Though, nothing to shame of, actually. IPV6_ADDRFORM was mad,
but IPv4 mapped addresses are mad^3. So, until IPV6_V6ONLY becomes usable,
port spaces are shared and the only way to write sane dual-protocol code
is IPV6_ADDRFORM.

:-) This is not objection against removal. Let it happen simultaneously
with IPV6_V6ONLY.

Alexey
