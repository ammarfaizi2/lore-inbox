Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSCGOz2>; Thu, 7 Mar 2002 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293362AbSCGOzS>; Thu, 7 Mar 2002 09:55:18 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:52724 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S288800AbSCGOzE>;
	Thu, 7 Mar 2002 09:55:04 -0500
Date: Thu, 7 Mar 2002 15:54:49 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, rajancr@us.ibm.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Message-ID: <20020307145449.GA13062@win.tue.nl>
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com> <20020307145630.7d4aed95.rusty@rustcorp.com.au> <20020307143404.A8FFF3FE06@smtp.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307143404.A8FFF3FE06@smtp.linux.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 09:35:09AM -0500, Hubertus Franke wrote:
...

Long ago I submitted a patch that changed the max pid from 15 bits to
24 or 30 bits or so. (And of course removed the inefficiency noticed
by some people in the current thread.)
Probably this is a good moment to try and see what Linus thinks
about this today.

[Of course Albert Cahalan will object that this is bad for the columns
of ps output. Maybe Alan will mutter something about sysvipc.
Roughly speaking there are only advantages, especially since
I think we'll have to do this sooner or later, and in such cases
sooner is better.]
