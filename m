Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTADBot>; Fri, 3 Jan 2003 20:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTADBot>; Fri, 3 Jan 2003 20:44:49 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:23431 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S262492AbTADBos>; Fri, 3 Jan 2003 20:44:48 -0500
Date: Fri, 3 Jan 2003 17:53:20 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "J.A. Magallon" <jamagallon@able.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP Zero Copy for mmapped files
In-Reply-To: <20030104004153.GA16238@werewolf.able.es>
Message-ID: <Pine.LNX.4.51.0301031750550.20170@twinlark.arctic.org>
References: <3E161DFD.AB8D25AE@tin.it> <20030104004153.GA16238@werewolf.able.es>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2003, J.A. Magallon wrote:

> Apache2 uses mmap() to open files ??
> So then there is a reason to include it in my patchset...

apache2.x uses sendfile.  see the apr library (where you can find sendfile
code for linux, freebsd, hpux, aix, mvs, solaris, and windoze...).  it
might also use mmap in some situations, most likely inherited from 1.x
(which uses only mmap).

-dean
