Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283278AbRLDSnK>; Tue, 4 Dec 2001 13:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281547AbRLDSmC>; Tue, 4 Dec 2001 13:42:02 -0500
Received: from hal.grips.com ([62.144.214.40]:29387 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S283163AbRLDSih>;
	Tue, 4 Dec 2001 13:38:37 -0500
Message-Id: <200112041837.fB4Iboq23957@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <geroldj@grips.com>
To: manu@agat.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: what happened with thread, from 2.2 to 2.4 ?!
Date: Tue, 4 Dec 2001 19:37:50 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <01120215334302.00742@extasia>
In-Reply-To: <01120215334302.00742@extasia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel version may not be the reason for this.
glibc 2.2.1 or 2.2.2 had a problem which some uninitialised variables when 
linked to pthread. (i think i can remember the strfmon call)
What is your glibc version ?

Gerold

On Sunday 02 December 2001 15:33, Blindauer Emmanuel wrote:
> Hi
> what happenned with thread from 2.2 to 2.4?
> I have some problems with threaded programs, working under 2.2 and no more
> under 2.4
