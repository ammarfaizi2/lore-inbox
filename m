Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVJBRvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVJBRvc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 13:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVJBRvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 13:51:32 -0400
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:46758 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S1751145AbVJBRvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 13:51:32 -0400
Date: Mon, 3 Oct 2005 01:51:16 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: 7eggert@gmx.de
Cc: Ed Tomlinson <tomlins@cam.org>, lokum spand <lokumsspand@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051002175116.GE5211@blackham.com.au>
References: <4SXfo-7hM-9@gated-at.bofh.it> <4T47e-5E-1@gated-at.bofh.it> <4TbLq-2VG-5@gated-at.bofh.it> <4TcR9-4sS-9@gated-at.bofh.it> <E1EM7KO-00014G-CK@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EM7KO-00014G-CK@be1.lrz>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 07:08:43PM +0200, Bodo Eggert wrote:
> Bernard Blackham <bernard@blackham.com.au> wrote:
> >> Is there any kernel api that adding would make cryopid more
> >> dependable/cleaner?
> > 
> > Currently a fair bit of information is obtained by injecting code
> > into the process's memory space, executing it, and reaping out the
> > results (eg, termcaps, file offsets, fcntl states, locks, signal
> > actions, etc).  Can't think of ways to make it cleaner off the top
> > of my head, but I'm open to ideas.
> 
> What about using an uml wrapper + vncserver?

Requires consciously doing so when you start it. It most certainly
could be done that way, but one of cryopid's aims is to work on any
running process without prior planning.

Interesting idea though - it'd be somewhat akin to porting
suspend-to-disk to UML (which has been on suspend2's todo list for a
while though :)

Bernard.
