Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSJ3CIf>; Tue, 29 Oct 2002 21:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSJ3CIf>; Tue, 29 Oct 2002 21:08:35 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:57757 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263281AbSJ3CIe>; Tue, 29 Oct 2002 21:08:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 18:24:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Waitz <tali@admingilde.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029225419.GA1463@admingilde.org>
Message-ID: <Pine.LNX.4.44.0210291819080.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Martin Waitz wrote:

> hi :)
>
> On Tue, Oct 29, 2002 at 04:19:23PM +0100, bert hubert wrote:
> > It is edge based instead of level based -
> seems i have to look closer at your papers/code
>
> what is the motivation to make it edge based?

You have two ways to know if "something" changed. You call everyone each
time and you ask him if his changed, or you call everyone one time by
saying "call me when you're changed". It's behind the "call me when you're
changed" phrase that lays the concept of edge triggered APIs. So, pretty
evidently, the answer to your question is : efficency.




- Davide


