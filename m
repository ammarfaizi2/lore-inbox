Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbRE1Wls>; Mon, 28 May 2001 18:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261190AbRE1Wli>; Mon, 28 May 2001 18:41:38 -0400
Received: from [195.154.50.21] ([195.154.50.21]:57867 "EHLO LAP")
	by vger.kernel.org with ESMTP id <S261309AbRE1Wl0>;
	Mon, 28 May 2001 18:41:26 -0400
Message-ID: <008d01c0e7c5$48998c90$0101a8c0@LAP>
From: "Vadim Lebedev" <vlebedev@aplio.fr>
To: "Philip Blundell" <philb@gnu.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP>  <E154VOX-0002jj-00@kings-cross.london.uk.eu.org>
Subject: Re: Potenitial security hole in the kernel 
Date: Tue, 29 May 2001 00:26:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-OriginalArrivalTime: 28 May 2001 22:26:47.0897 (UTC) FILETIME=[48998C90:01C0E7C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip,

The point is the panic will be executed in KERNEL and NOT  user mode.
Unless i'm missing something the sigcontext contains kernel mode and not
user mode context.

Vadim

----- Original Message -----
From: "Philip Blundell" <philb@gnu.org>
To: "Vadim Lebedev" <vlebedev@aplio.fr>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, May 29, 2001 12:21 AM
Subject: Re: Potenitial security hole in the kernel



