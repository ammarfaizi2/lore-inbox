Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUBRUaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267710AbUBRUaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:30:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60288 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267476AbUBRUaG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:30:06 -0500
Date: Wed, 18 Feb 2004 15:32:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?US-ASCII?Q?Markus_H=E4stbacka?= <midian@ihme.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NET] 64 bit byte counter for 2.6.3
In-Reply-To: <20040218101711.25dda791@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.53.0402181527000.7318@chaos>
References: <1077123078.9223.7.camel@midux> <20040218101711.25dda791@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Markus Hästbacka <midian@ihme.org> wrote:
> Ok, Here's a patch for 64 bit byte counters for 2.6.3. For any intrested
> users to try.

Manipulation of a 'long long' is not atomic in 32 bit architectures.
Please explain how we don't care, if we shouldn't care. Also some
/proc entries might get read incorrectly with existing tools.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an Pentium III machine (1797.90
BogoMips).
            Note 96.31% of all statistics are fiction.


