Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUFDBK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUFDBK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUFDBK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:10:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264346AbUFDBKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:10:44 -0400
Date: Thu, 3 Jun 2004 18:08:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org, jsun@mvista.com, savl@dev.rtsoft.ru
Subject: Re: input_event size mismatch between 64bit kernel and 32bit
 userland ...
Message-Id: <20040603180847.0a03621a.davem@redhat.com>
In-Reply-To: <20040603180728.F25577@mvista.com>
References: <20040603180728.F25577@mvista.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004 18:07:28 -0700
Jun Sun <jsun@mvista.com> wrote:

> Pavel Kiryukhin discovered this problem while he is developing
> 64bit MIPS kernel.  With his permission I am forwarding this question
> to lkml and we would be interested to know how x86_64 solves this
> problem.

x86_64 doesn't solve this problem, it's broken there too

Some CONFIG_COMPAT code needs to be added to the input layer
I guess
