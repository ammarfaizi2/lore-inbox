Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbRCVLsc>; Thu, 22 Mar 2001 06:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRCVLsW>; Thu, 22 Mar 2001 06:48:22 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:25637 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S131240AbRCVLsL>;
	Thu, 22 Mar 2001 06:48:11 -0500
Message-ID: <20010322124727.A5115@win.tue.nl>
Date: Thu, 22 Mar 2001 12:47:27 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com> <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva>; from Rik van Riel on Wed, Mar 21, 2001 at 08:48:54PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 08:48:54PM -0300, Rik van Riel wrote:
> On Wed, 21 Mar 2001, Patrick O'Rourke wrote:

> > Since the system will panic if the init process is chosen by
> > the OOM killer, the following patch prevents select_bad_process()
> > from picking init.

There is a dozen other processes that must not be killed.
Init is just a random example.

> One question ... has the OOM killer ever selected init on
> anybody's system ?

Last week I installed SuSE 7.1 somewhere.
During the install: "VM: killing process rpm",
leaving the installer rather confused.
(An empty machine, 256MB, 144MB swap, I think 2.2.18.)

Last month I had a computer algebra process running for a week.
Killed. But this computation was the only task this machine had.
Its sole reason of existence.
Too bad - zero information out of a week's computation.
(I think 2.4.0.)

Clearly, Linux cannot be reliable if any process can be killed
at any moment. I am not happy at all with my recent experiences.

Andries



