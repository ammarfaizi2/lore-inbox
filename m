Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281132AbRKENEZ>; Mon, 5 Nov 2001 08:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKENEG>; Mon, 5 Nov 2001 08:04:06 -0500
Received: from mnh-1-25.mv.com ([207.22.10.57]:54020 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S281128AbRKEND7>;
	Mon, 5 Nov 2001 08:03:59 -0500
Message-Id: <200111051422.JAA01263@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification 
In-Reply-To: Your message of "Sun, 04 Nov 2001 21:30:38 PST."
             <E160cLH-0001Nw-00@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Nov 2001 09:22:09 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bodnar42@phalynx.dhs.org said:
> Nope, last I checked O_DIRECT enforces buffer and file offset
> alignment.  Normal apps wouldn't work very well at all. 

Except that the apps won't be the ones doing O_DIRECT IO.  It'll be UML, and
it can presumably provide whatever alignment is required.

> Maybe UML needs some hacks around  the whole caching issue?

Not that I can see...

				Jeff

