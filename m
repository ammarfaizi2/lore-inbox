Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278315AbRJMPfC>; Sat, 13 Oct 2001 11:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278316AbRJMPen>; Sat, 13 Oct 2001 11:34:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58847 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278315AbRJMPea>;
	Sat, 13 Oct 2001 11:34:30 -0400
Date: Sat, 13 Oct 2001 11:35:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Signal9 <signal9@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in VFS ?
In-Reply-To: <01101312321500.00286@apocalipsis>
Message-ID: <Pine.GSO.4.21.0110131133320.2021-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Oct 2001, Signal9 wrote:

>  Here goes the complete function:

[snip]

It's completely broken.  To start with, it's leaking vfsmounts like
hell.  But the real question is "what the hell is it trying to do?"

