Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316178AbSETSMR>; Mon, 20 May 2002 14:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSETSMQ>; Mon, 20 May 2002 14:12:16 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:45707 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S316178AbSETSMP>; Mon, 20 May 2002 14:12:15 -0400
Date: Mon, 20 May 2002 11:12:15 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Michael Hoennig <michael@hostsharing.net>
cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
In-Reply-To: <20020520165312.3fb29ba2.michael@hostsharing.net>
Message-ID: <Pine.LNX.4.44.0205201102500.2227-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Michael Hoennig wrote:

> Why do you ignore my example? In my example the use who runs the webserver
> owns all the files, that is wrong. With the suid bit on directories, this
> could be fixed.

CAP_FCHOWN would appear to accomplish what you need (with the bonus of
already existing in modern linux kernels)... the webserver should be able
to chown away a file if it's given this capability.

-dean

