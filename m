Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271106AbRHTGQw>; Mon, 20 Aug 2001 02:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271095AbRHTGQc>; Mon, 20 Aug 2001 02:16:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50986 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271093AbRHTGQa>; Mon, 20 Aug 2001 02:16:30 -0400
To: Paul <set@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 [I] just run xdos
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com>
	<m166bjokre.fsf@frodo.biederman.org>
	<20010819214322.D1315@squish.home.loc>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2001 00:09:27 -0600
In-Reply-To: <20010819214322.D1315@squish.home.loc>
Message-ID: <m1snenmfe0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul <set@pobox.com> writes:

> 	Dear Eric;
> 
> 	No, the program isnt setuid, nor run by root, and no
> ports specified in the config. Let me know if there is anything
> further I can do.

O.k.  Then it is most definentily not dosemu, but a kernel or an X bug.
Running dosemu as just dos so it runs in a terminal window will rule
out X.

If you can rule out X stracing dosemu might be of some help.   The
challenge now is to track down what dosemu is doing that is triggering
the problem. 

As an interrupt handler is where the oops is occuring.  Finding an
immediate cause and effect could be tricky.

Eric
