Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135698AbRD2IkE>; Sun, 29 Apr 2001 04:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135699AbRD2Ijy>; Sun, 29 Apr 2001 04:39:54 -0400
Received: from www.linux.org.uk ([195.92.249.252]:46088 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S135698AbRD2Ijf>;
	Sun, 29 Apr 2001 04:39:35 -0400
Date: Sun, 29 Apr 2001 09:39:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zerocopy implementation issues
Message-ID: <20010429093902.B30243@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010429005206.J21792@flint.arm.linux.org.uk> <15083.40318.158099.137018@pizda.ninka.net> <20010429072342.B30041@flint.arm.linux.org.uk> <15083.52835.992666.897323@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15083.52835.992666.897323@pizda.ninka.net>; from davem@redhat.com on Sun, Apr 29, 2001 at 01:18:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 01:18:43AM -0700, David S. Miller wrote:
> When I don't have the time, my port tends to break too.
> This isn't news to you is it?

Of course not.

>         testl $2, %edi                  # Check alignment.

Hang on - you mean that this isn't equivalent to:

	dst & 2

?

If it is, I don't see how his code can work, but then I'm not
an expert at reading x86 code unlike you!

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

