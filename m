Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbRG2AIU>; Sat, 28 Jul 2001 20:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbRG2AIK>; Sat, 28 Jul 2001 20:08:10 -0400
Received: from pD9E1EFED.dip.t-dialin.net ([217.225.239.237]:7438 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S265277AbRG2AIG>; Sat, 28 Jul 2001 20:08:06 -0400
Date: Sun, 29 Jul 2001 02:08:12 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Lawrence Greenfield <leg+@andrew.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010729020812.D9350@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Lawrence Greenfield <leg+@andrew.cmu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010729011552.B9350@emma1.emma.line.org> <Pine.LNX.4.33L.0107282046560.11893-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107282046560.11893-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 28 Jul 2001, Rik van Riel wrote:

> > The standard is only useful if it specifies how to get data safely on
> > disk - it is quite explicit for fsync(), but you evidently cannot
> > fsync() a link().
> 
> As Linus said, fsync() on the directory.

Relying on that to work on other operating systems is no better than
demanding synchronous meta data writes: relying on undocumented
behaviour.

If we spake about Linux-specific applications, that'd be okay, but we
speak about portable applications, and the diversity is bigger than
useful. Speed is not the only problem the OS has to solve.

-- 
Matthias Andree
