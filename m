Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264695AbUEYUAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbUEYUAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUEYUAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:00:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13484 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264695AbUEYUAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:00:07 -0400
Date: Tue, 25 May 2004 12:59:28 -0700
From: "David S. Miller" <davem@redhat.com>
To: knobi@knobisoft.de
Cc: flind@haystack.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Multicast problems between 2.4.20 and 2.4.21?
Message-Id: <20040525125928.444087a4.davem@redhat.com>
In-Reply-To: <20040525181510.68862.qmail@web13902.mail.yahoo.com>
References: <20040525103843.0c764c47.davem@redhat.com>
	<20040525181510.68862.qmail@web13902.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 11:15:10 -0700 (PDT)
Martin Knoblauch <knobi@knobisoft.de> wrote:

>   what is the name of the sysctl, and when was it added to 2.4? What
> about 2.6.x?

/proc/sys/net/ipv4/conf/${DEV}/force_igmp_version

Replace ${DEV} with a specific device name, "default", or "all"
as desired.

It got added to 2.4.25 I believe, and yes 2.6.x has it too.
