Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbTANV4B>; Tue, 14 Jan 2003 16:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbTANVzn>; Tue, 14 Jan 2003 16:55:43 -0500
Received: from [66.70.28.20] ([66.70.28.20]:61964 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265368AbTANVzl>; Tue, 14 Jan 2003 16:55:41 -0500
Date: Tue, 14 Jan 2003 23:00:53 +0100
From: DervishD <raul@pleyades.net>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030114220053.GA241@DervishD>
References: <20030114195005.GD162@DervishD> <Pine.LNX.3.95.1030114145417.13752A-100000@chaos.analogic.com> <20030114202359.GD15412@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030114202359.GD15412@mark.mielke.cc>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Mark :)

> > In any event, a "whole line of text" isn't going to overrun it. 
> Looking at the code, it looks to me as if argv[0] can be any size up to
> _SC_ARG_MAX, with the restraining factor being that the environment
> variables and the other arguments must fit in the same space.
> Is this not correct?

    This is correct, but it is a maximum, not a minimum.

    Raúl
