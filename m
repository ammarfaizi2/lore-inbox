Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932807AbWJIN31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbWJIN31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbWJIN31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:29:27 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:59329 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932807AbWJIN30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:29:26 -0400
Date: Mon, 9 Oct 2006 09:28:55 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jean-Marc Saffroy <saffroy@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] kdump2gdb: analyze kdumps with gdb (well, almost)
Message-ID: <20061009132855.GA25559@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <Pine.LNX.4.64.0610061742270.9250@erda.mds>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610061742270.9250@erda.mds>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 06:42:00PM +0200, Jean-Marc Saffroy wrote:
> Hello folks,
> 
> Following earlier discussions on how nice it would be to use gdb on kdump 
> cores, I took some time and wrote a small tool to do just that:
>   http://jeanmarc.saffroy.free.fr/kdump2gdb/
> 
> The main limitation is that there is absolutely no backtrace of 
> non-running tasks yet, but I will try to see how it can be done. Also, it 
> works only on x86-64, but people are welcome to contribute ports. :)

Hi Jean,

Interesting stuff. Documentation/kdump/gdbmacros.txt already seems to
be containing various macros for seeing the back traces of non-running 
threads. Won't these help?

-Vivek
