Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267918AbRGZNSF>; Thu, 26 Jul 2001 09:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbRGZNRz>; Thu, 26 Jul 2001 09:17:55 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:56962 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267918AbRGZNRo>; Thu, 26 Jul 2001 09:17:44 -0400
Date: Thu, 26 Jul 2001 15:17:49 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726151749.M17244@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <20010726143002.E17244@emma1.emma.line.org> <Pine.LNX.4.33L.0107260956520.20326-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107260956520.20326-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Rik van Riel wrote:

> In fact, knowing how hard disks work mechanically, only
> journaling filesystems could have an extention to make
> this work.  Ie. this is NOT something you can rely on ;)

This is not about failing hard disks. It is about premature
acknowledgment of something which has not happened at that time.

Linux cannot possibly fix all incomplete protocols, specifications and
implementation, but it can fix its own behaviour.

Everything is about speed, and allowing the MTA to use a (weaker)
dirsync rather than allsync option would speed things up without
sacrificing reliability.

MTA reliability is NOT about failing disk drives. If it falls over, you
notice that. If files are in the wrong directory or not there at all,
you don't necessarily notice until someone complains.

Please don't get in the way of finally fixing things just because
someone might have a broken item that could endanger your data. I have a
huge magnet here...

The competition is there and it has names: BSD + ufs + softupdates,
Solaris + logging ufs. Read MTA mailing lists before obstructing.

Thanks.

-- 
Matthias Andree
