Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWDOVsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWDOVsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWDOVsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:48:17 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:32199 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965152AbWDOVsR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:48:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ujstl1yilo3ZPXqXfp428f8E/v7mfCXoGlyh4PhbD+CYDJW8Vos89WfyTOOhyrOhrcegumNC02+dMWozPp5ZlAK/pjyO5We5Eex2shUGWHshe4V1oAUoZLquHgOTaSAONja431ySHzHU1mwAF++zpFlUsKqGhKcj1LtZrpm3NTo=
Message-ID: <35fb2e590604151448h35169b78s4b62105d462f5b9a@mail.gmail.com>
Date: Sat, 15 Apr 2006 22:48:16 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Libor Vanek" <libor.vanek@gmail.com>
Subject: Re: Connector - how to start?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/06, Libor Vanek <libor.vanek@gmail.com> wrote:

> I'd like to start writing some small module using connector to send
> messages to/from user-space. Unfortunately I'm absolutely not familiar
> with netlink/connector API usage and I couldn't find any usefull
> documentation (yes, I read Documentation/connector/ and tried Google).

So, time to ask the question.

I've been thinking for the past couple of weeks of hacking at the
different users of netlink and trying to get everyone to play nicely
together - if we're pushing things like connector, why can't we make
this a general solution? (read: why do uevents have to be seperate?
why are we forced to a particular protocol number with connector?
etc.?).

Jon.
