Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbTIJMJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTIJMJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:09:47 -0400
Received: from mid-2.inet.it ([213.92.5.19]:5046 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S262803AbTIJMJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:09:46 -0400
Message-ID: <03ae01c37795$063561a0$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: <alexander.riesen@synopsys.COM>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <20030910115259.GA28632@Synopsys.COM>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 14:14:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Compatibility is not a problem. Simply rewrite the write() and read()
> > for pipes in order to make them do the same thing done by zc_send()
> > and zc_receive().  Or, if you are not referring to pipes, rewrite the
> > support level of you anchient IPC primitives in order to make them do
> > the same thing done by zc_send() and zc_receive().
> 
> If it is possible, why new user-side interface?

Because my programming model is clear and easy.
Linux one's is far from being so, in my opinion.

Bye,
Luca
