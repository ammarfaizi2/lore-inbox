Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTKXSrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTKXSrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:47:47 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12041
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262725AbTKXSrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:47:46 -0500
Date: Mon, 24 Nov 2003 10:47:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kimmo Sundqvist <rabbit80@mbnet.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interactivity scheduler tests and the FreeBSD implementation
Message-ID: <20031124184742.GB2190@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Kimmo Sundqvist <rabbit80@mbnet.fi>,
	linux-kernel@vger.kernel.org
References: <200311221012.04448.rabbit80@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311221012.04448.rabbit80@mbnet.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 10:12:04AM +0200, Kimmo Sundqvist wrote:
> I took a look at
> 
> http://www.chesapeake.net/~jroberson/ULE.pdf
> 
> and I'd like to know, has the situation been improved much, or the same tests 
> rerun with the newest linux schedulers?  Any other comments about the 
> document?

I'm still reading through the document, but it is testing against 2.5.73,
which was before Con's extensive scheduler interactivity improvements.

It looks like the ULE developers have created the tool, and test suite
needed to show problems with schedulers that has been asked for repeatedly
on this list.

Now all that is needed is for someone to put that in LTP.

It would be most interesting to see a comparison of each of Con's patches
that he made while testing out his ideas...
