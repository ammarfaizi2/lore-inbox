Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbRFKSMC>; Mon, 11 Jun 2001 14:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbRFKSLw>; Mon, 11 Jun 2001 14:11:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54761 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262618AbRFKSLi>;
	Mon, 11 Jun 2001 14:11:38 -0400
Message-ID: <3B2509CD.F898D2AE@mandrakesoft.com>
Date: Mon, 11 Jun 2001 14:11:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Golds <jgolds@resilience.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with arch/i386/kernel/apm.c
In-Reply-To: <3B25068B.53F2968A@resilience.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Golds wrote:
> Please let me know if this is correct, I can provide a simple patch if
> needed.  What I am really desiring to know is if there are any devices
> that depend on the apm::send_event(APM_NORMAL_RESUME) happening while
> interrupts are disabled.

Good spotting...  If any devices depend on what you describe, I would
argue that their drivers should handle that not the core apm code...

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
