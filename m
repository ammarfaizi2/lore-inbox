Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQJaWpM>; Tue, 31 Oct 2000 17:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbQJaWpC>; Tue, 31 Oct 2000 17:45:02 -0500
Received: from chiara.elte.hu ([157.181.150.200]:46343 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129029AbQJaWot>;
	Tue, 31 Oct 2000 17:44:49 -0500
Date: Wed, 1 Nov 2000 00:54:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF465F.4EEB811A@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011010040030.17233-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Jeff V. Merkey wrote:

> A "context" is usually assued to be a "stack". [...]

a very clintonesque definition indeed ;-)

what is relevant is the latency to switch from one process to another one.
And this is what we call a context switch. It includes scheduling
decisions and all sorts of other stuff. You are comparing stack &
caller-saved register switching performance (which is just a small part of
context switching and has no standing alone) against full Linux context
switch performance (this is what i quoted), and thus you have won my
'Mindcraft benchmark of the day' award :-)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
