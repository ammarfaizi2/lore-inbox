Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbREaIfG>; Thu, 31 May 2001 04:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbREaIe4>; Thu, 31 May 2001 04:34:56 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:27433 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S263031AbREaIem>;
	Thu, 31 May 2001 04:34:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.5-ac4 es1371.o unresolved symbols 
In-Reply-To: Your message of "Thu, 31 May 2001 10:06:54 +0200."
             <20010531100654.A1759@suse.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 May 2001 18:34:20 +1000
Message-ID: <17420.991298060@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2001 10:06:54 +0200, 
Vojtech Pavlik <vojtech@suse.cz> wrote:
>On Thu, May 31, 2001 at 05:52:39PM +1000, Keith Owens wrote:
>> When the user has gameport hardware compiled it as a module and they
>> have es1371 bult into the kernel then es1371 silently ignores the
>> gameport, even if the gameport modules has been loaded.  This violates
>> the principle of least surprise, a user configuring both gameport and
>> es1371 expects to use the gameport, kbuild should support that instead
>> of silently ignoring the combination.
>
>True. Is this worse than the ugliness in your patch?

Only kernel developers see the ugly patch.  The unexpected presence or
absence of gameport code affects all users.  User always win that
argument.  Adding a warning is just as bad, kbuild either generates a
valid config or nothing at all.  Users never check warnings anyway :(.

