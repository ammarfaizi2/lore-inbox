Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312253AbSDDMlQ>; Thu, 4 Apr 2002 07:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312311AbSDDMlG>; Thu, 4 Apr 2002 07:41:06 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:20742 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312253AbSDDMky>; Thu, 4 Apr 2002 07:40:54 -0500
Date: Thu, 4 Apr 2002 13:40:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020404134046.H27376@flint.arm.linux.org.uk>
In-Reply-To: <E16t5oc-0005kr-00@the-village.bc.nu> <Pine.LNX.4.33.0204041245340.1475-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 01:01:47PM +0100, Tigran Aivazian wrote:
> Namely, in the sense that it is inconsistent with the
> similar situation in the case of libraries or even system calls.

A GPL library can only be linked with other GPL-compatible code.  A LGPL
library can be linked with any GPL-compatible or GPL-incompatible code.
The LGPL has specific clauses in it that allows you to link GPL-incompatible
code (see LGPL paragraph 5).  It seems that you're missing that distinction.

This is why glibc and other libraries are LGPL, not GPL.  If glibc was GPL,
all the binary-only applications in user space would have to supply their
own C library.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

