Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290303AbSAPAre>; Tue, 15 Jan 2002 19:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290305AbSAPArK>; Tue, 15 Jan 2002 19:47:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65029 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290308AbSAPApP>; Tue, 15 Jan 2002 19:45:15 -0500
Date: Tue, 15 Jan 2002 16:44:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: John Weber <weber@nyc.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <20020115194316.I17477@redhat.com>
Message-ID: <Pine.LNX.4.33.0201151644180.1213-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Benjamin LaHaise wrote:
>
> Well, I actually disagree on this.  For large include files (fs.h is the
> worst), and complicated arrangement, this technique eliminates spurious
> includes and saves a lot on compile time (really!).

Numbers please.

I'd MUCH rather just clean up the include file hierarchy than have these
kinds of non-local knowledge issues.

		Linus

