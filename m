Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTECOpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTECOpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:45:39 -0400
Received: from mark.mielke.cc ([216.209.85.42]:33299 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S263268AbTECOpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:45:39 -0400
Date: Sat, 3 May 2003 11:04:54 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile
Message-ID: <20030503150454.GA10424@mark.mielke.cc>
References: <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no> <20030502024147.GA523@mark.mielke.cc> <3EB1F1CD.4060702@nortelnetworks.com> <20030502210648.GA5322@mark.mielke.cc> <b8v3aj$p2j$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8v3aj$p2j$1@news.cistron.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 12:42:59AM +0000, Miquel van Smoorenburg wrote:
> In article <20030502210648.GA5322@mark.mielke.cc>,
> Mark Mielke  <mark@mark.mielke.cc> wrote:
> >One question it raises in my mind, is whether there would be value in
> >improving write()/send() such that they detect that the userspace
> >pointer refers entirely to mmap()'d file pages, and therefore no copy
> >of data from userspace -> kernelspace should be performed.
> You mean like
> http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week00/0056.html

Yes, definately, and thank you for referring us to work that has already
been done.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

