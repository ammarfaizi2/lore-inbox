Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318470AbSGZUoG>; Fri, 26 Jul 2002 16:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318483AbSGZUoG>; Fri, 26 Jul 2002 16:44:06 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:58240 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S318470AbSGZUoF>; Fri, 26 Jul 2002 16:44:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 26 Jul 2002 13:49:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: davidm@hpl.hp.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: performance experiment
In-Reply-To: <15681.38933.698148.860188@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0207261344250.1561-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, David Mosberger wrote:

>   Davide> i posted a 95% matching patch about one year ago but it fell
>   Davide> inside the Alan drop basket :-) basically
>
> Yes, there is nothing deep in the patch.  If it wasn't for
> register-starved architectures such as x86, it would be the obviously
> correct thing to do.  Actually, it's a lot easier to convert register
> accesses into memory accesses than vice versa, so in principle, the
> new loop should do better even on x86 (this reasoning is what triggers
> my interest in how Crusoe fares).

IMHO the patch makes sense, it reduces memory loads and it "helps" the
compiler to correctly allocate registers.



- Davide


