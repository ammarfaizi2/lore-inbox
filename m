Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbRCWL3a>; Fri, 23 Mar 2001 06:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130606AbRCWL3L>; Fri, 23 Mar 2001 06:29:11 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:53295 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S130552AbRCWL27>;
	Fri, 23 Mar 2001 06:28:59 -0500
Message-ID: <20010323122815.A6428@win.tue.nl>
Date: Fri, 23 Mar 2001 12:28:15 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Rik van Riel <riel@conectiva.com.br>,
        Michael Peddemors <michael@linuxmagic.com>
Cc: Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva>; from Rik van Riel on Fri, Mar 23, 2001 at 04:04:09AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 04:04:09AM -0300, Rik van Riel wrote:
> On 22 Mar 2001, Michael Peddemors wrote:
> 
> > Here, Here.. killing qmail on a server who's sole task is running mail
> > doesn't seem to make much sense either..
> 
> I won't defend the current OOM killing code.
> 
> Instead, I'm asking everybody who's unhappy with the
> current code to come up with something better.

To a murderer: "Why did you kill that old lady?"
Reply: "I won't defend that deed, but who else should I have killed?"

Andries - getting more and more unhappy with OOM

Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 2019 (emacs).
Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 1407 (emacs).
Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 1495 (emacs).
Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 2800 (rpm).

[yes, that was rpm growing too large, taking a few emacs sessions]
[2.4.2]
