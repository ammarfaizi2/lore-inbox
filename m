Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSJOSZO>; Tue, 15 Oct 2002 14:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264747AbSJOSZN>; Tue, 15 Oct 2002 14:25:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22912 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264711AbSJOSZJ>; Tue, 15 Oct 2002 14:25:09 -0400
Date: Tue, 15 Oct 2002 14:31:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Olivier Galibert <galibert@pobox.com>
cc: Daniele Lugli <genlogic@inrete.it>, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
In-Reply-To: <20021014163707.A2809@zalem.puupuu.org>
Message-ID: <Pine.LNX.3.95.1021015143012.2186A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Olivier Galibert wrote:

> On Mon, Oct 14, 2002 at 04:33:50PM -0400, Richard B. Johnson wrote:
> > > #define current get_current()
> 
> > This cannot be the reason for your problem. The name of a structure
> > member has no connection whatsoever with the name of any function or
> > definition.
> 
> You forgot the effect of the parenthesis.  This isn't a name-changing
> macro, this is a variable-to-function-call changing macro.
> 
>   OG.
> 

Yep. But if the originator can not tried to compile kernel headers
with g++, an appropriate diagnostic would have been caught as shown.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

