Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319120AbSHTA3p>; Mon, 19 Aug 2002 20:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319124AbSHTA3o>; Mon, 19 Aug 2002 20:29:44 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:2962 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S319120AbSHTA3n>;
	Mon, 19 Aug 2002 20:29:43 -0400
Date: Tue, 20 Aug 2002 02:33:46 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: MAX_PID changes in 2.5.31
Message-ID: <20020820003346.GA4592@win.tue.nl>
References: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain> <1029799751.21212.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029799751.21212.0.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 12:29:11AM +0100, Alan Cox wrote:

> libc5 is very much 16bit pid throughout.

Can you clarify?

Andries


#define _IO_pid_t _G_pid_t
typedef int _G_pid_t;
typedef int __pid_t;
