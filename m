Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSFTVtL>; Thu, 20 Jun 2002 17:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSFTVtK>; Thu, 20 Jun 2002 17:49:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55542 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315627AbSFTVtJ>; Thu, 20 Jun 2002 17:49:09 -0400
Subject: Re: ptrace vs /proc
From: Robert Love <rml@ufl.edu>
To: Pradeep Padala <ppadala@cise.ufl.edu>
Cc: Andrew D Kirch <Trelane@Trelane.Net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206201742170.18444-100000@lin114-02.cise.ufl.edu>
References: <Pine.LNX.4.44.0206201742170.18444-100000@lin114-02.cise.ufl.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 14:49:07 -0700
Message-Id: <1024609747.922.0.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-20 at 14:46, Pradeep Padala wrote:

> As far as I could investigate, I didn't find any such interface in linux. 
> Programs like strace do the tracing through ptrace only.
> 
> Please let me know if you know more about this.

There is no such interface in Linux and currently no plans to develop a
Solaris-style /proc.

Some work that may go into 2.5, task ornaments, may facilitate easier
debugging and perhaps make such a /proc more feasible in the future.

	Robert Love


