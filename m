Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVA0TUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVA0TUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVA0TUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:20:40 -0500
Received: from alog0423.analogic.com ([208.224.222.199]:48768 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262591AbVA0TUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:20:34 -0500
Date: Thu, 27 Jan 2005 14:19:33 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: John Richard Moser <nigelenki@comcast.net>
cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org>
 <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlemen,

Isn't the return address on the stack an offset in the
code (.text) segment?

How would a random stack-pointer value help? I think you would
need to start a program at a random offset, not the stack!
No stack-smasher that worked would care about the value of
the stack-pointer.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
