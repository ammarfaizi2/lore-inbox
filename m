Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbSLEQzI>; Thu, 5 Dec 2002 11:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbSLEQzI>; Thu, 5 Dec 2002 11:55:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13066 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267351AbSLEQyw>;
	Thu, 5 Dec 2002 11:54:52 -0500
Message-ID: <3DEF86A2.2010704@pobox.com>
Date: Thu, 05 Dec 2002 12:02:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: how is the asm-generic to be used?
References: <3DEF1DB1.98CD4BB3@mvista.com>
In-Reply-To: <3DEF1DB1.98CD4BB3@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> Lets say there is a bit of code in the kernel ( i.e.
> .../kernel/ ) that needs a function that is in an
> asm-gneric/*.h file.  Now someone comes along and does an
> asm-x386/*.h with the same functionality but much faster asm
> functions.  How should the using code be set up to get the
> faster asm version if it exists and the generic version if
> it does not?


Can you be more specific?  :)

asm-generic is for things that belong in include/asm-$ARCH but are also 
shared across multiple architectures.

