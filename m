Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSGMNN1>; Sat, 13 Jul 2002 09:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSGMNN0>; Sat, 13 Jul 2002 09:13:26 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19950 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312590AbSGMNM5>; Sat, 13 Jul 2002 09:12:57 -0400
Subject: Re: PATCH: compile the kernel with -Werror
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020713102615.H739@alhambra.actcom.co.il>
References: <20020713102615.H739@alhambra.actcom.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 15:24:03 +0100
Message-Id: <1026570243.9958.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 08:26, Muli Ben-Yehuda wrote:
> A full kernel compilation, especially when using the -j switch to
> make, can cause warnings to "fly off the screen" without the user
> noticing them.

May I suggest the user learns to use the command line properly. Adding
-Werror doesn't help because gcc emits far too many bogus warnings for
that.

