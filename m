Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289888AbSA2VN4>; Tue, 29 Jan 2002 16:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289895AbSA2VNg>; Tue, 29 Jan 2002 16:13:36 -0500
Received: from waste.org ([209.173.204.2]:17880 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289888AbSA2VNa>;
	Tue, 29 Jan 2002 16:13:30 -0500
Date: Tue, 29 Jan 2002 15:13:10 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201291302210.1283-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0201291512330.25443-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Linus Torvalds wrote:

>
> On Tue, 29 Jan 2002, Oliver Xymoron wrote:
> >
> > fork:
> >   detach page tables from parent
>
>  - leave the option ot just mark them read-only on architectures that
>    support it (ie x86, I think alpha does this too).

I don't think read-only for the tables is sufficient if the pages
themselves are writable.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

