Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSIZPGE>; Thu, 26 Sep 2002 11:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSIZPGD>; Thu, 26 Sep 2002 11:06:03 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:20985
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261365AbSIZPF5>; Thu, 26 Sep 2002 11:05:57 -0400
Subject: Re: Kernel call chain search tool?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D913D58.49D855DB@kegel.com>
References: <3D913D58.49D855DB@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 16:15:48 +0100
Message-Id: <1033053348.1269.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-25 at 05:36, Dan Kegel wrote:
> <prelude>
> I have a large multithreaded program that has a habit of using too
> much memory, and as a safeguard, I want to kill it before it makes
> the system unstable.  The OOM killer often guesses wrong, and RLIMIT_AS
> kills too soon because of the address space used up by the many thread
> stacks.
> So I'd like an RLIMIT_RSS that just kills the fat process.

The RSS limit isnt a "kill" limit in Unix. its a residency limit. Its
preventing the obese process from getting more than a certain amount of
RAM as opposed to swap

