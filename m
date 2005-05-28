Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVE1BsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVE1BsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 21:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVE1BsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 21:48:11 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:39631 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261922AbVE1BsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 21:48:09 -0400
Subject: Re: disowning a process
From: Steven Rostedt <rostedt@goodmis.org>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1117244316.6477.22.camel@localhost.localdomain>
References: <42975945.7040208@davyandbeth.com>
	 <1117217088.4957.24.camel@localhost.localdomain>
	 <42976D3A.5020200@davyandbeth.com>
	 <1117227438.5730.235.camel@localhost.localdomain>
	 <4297AE6F.9040707@davyandbeth.com>
	 <1117244316.6477.22.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 27 May 2005 21:48:03 -0400
Message-Id: <1117244883.6477.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 21:38 -0400, Steven Rostedt wrote:
>        } else if (!pid) {
>                if (daemon(1,1) < 0) {
>                        perror("daemon");
>                        exit(-1);
>                }

You probably want to use daemon(0,0), I was just playing with this, and
forgot to put it back. See man daemon for details.

-- Steve


