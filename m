Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQJaUWX>; Tue, 31 Oct 2000 15:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbQJaUWN>; Tue, 31 Oct 2000 15:22:13 -0500
Received: from chiara.elte.hu ([157.181.150.200]:40711 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129050AbQJaUVi>;
	Tue, 31 Oct 2000 15:21:38 -0500
Date: Tue, 31 Oct 2000 22:31:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Pavel Machek <pavel@suse.cz>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF27F9.8DE77CFA@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010312229030.15159-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Jeff V. Merkey wrote:

> It relies on an anomoly in the design of Intel's cache controllers,
> and with memory based applications, I can get 120% scaling per
> procesoor by jugling the working set of executable code cached accros
> each processor.  There's sample code with this kernel you can use to
> verify....

FYI, this is a very old concept and a scalability FAQ item. It's called
"sublinear scaling", and SGI folks have already published articles about
it 10 years ago.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
