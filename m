Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSIQUJu>; Tue, 17 Sep 2002 16:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSIQUJu>; Tue, 17 Sep 2002 16:09:50 -0400
Received: from ns1.cypress.com ([157.95.67.4]:41875 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S264630AbSIQUJt>;
	Tue, 17 Sep 2002 16:09:49 -0400
Message-ID: <3D878CF7.3040304@cypress.com>
Date: Tue, 17 Sep 2002 15:13:43 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       gen-lists@blueyonder.co.uk
Subject: Re: Problems accessing USB Mass Storage
References: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net> <3D878788.2030603@cypress.com> <20020917125817.B11583@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthew Dharm wrote:
> The device may not actually have the beginning few sectors.  Use skip= to
> try to read something from the middle of the media.

Give that a go Mark.

Try a few values like 25, 50, 75, and 100. with bs=1k and
unset (default 512 byte).

> Yes, I actually have seen this before.  The firmware 'fakes' a partition
> table on the first attempt to read one, but sector 0 really isn't there.

Am I glad I have a CF camera:) What kind of
junk is SmartMedia, missing sectors? Ugh!

	-Thomas

