Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264832AbSKEMSX>; Tue, 5 Nov 2002 07:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264833AbSKEMSX>; Tue, 5 Nov 2002 07:18:23 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:42405 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S264832AbSKEMSX> convert rfc822-to-8bit; Tue, 5 Nov 2002 07:18:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19: network related kernel panic
Date: Tue, 5 Nov 2002 13:24:19 +0100
X-Mailer: KMail [version 1.4]
References: <200210211530.35241.jan-hinnerk_reichert@hamburg.de>
In-Reply-To: <200210211530.35241.jan-hinnerk_reichert@hamburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211051324.19846.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi again,
>
> I now have had three "kernel panic" messages with similar stack traces (in
> about one week).
>
> The error is an "divide error" in "kfree". After the second error I have
> changed kernel configuration to narrow the possibilities and to get extra
> debug information.
> The third error appeared in "kmem_extra_free_check" (also a divide error).
[...]
> If I read the stack trace right, the packet comes from pppd and should be
> send via the bridge to the other RTL8139.
[...]

I have now removed all MARK targets from my netfilter rules and the machine 
has been running for three weeks without problems.

Does anyone know of problems with MARK?
Were there any fixes in relevant code since 2.4.19?

Thanks in advance
 Jan-Hinnerk

