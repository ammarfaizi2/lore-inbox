Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131663AbQJ2NEG>; Sun, 29 Oct 2000 08:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131684AbQJ2ND5>; Sun, 29 Oct 2000 08:03:57 -0500
Received: from pacific.usatoday.com ([167.8.29.64]:33141 "HELO
	mail9.usatoday.com") by vger.kernel.org with SMTP
	id <S131663AbQJ2NDk>; Sun, 29 Oct 2000 08:03:40 -0500
Date: Sun, 29 Oct 2000 08:03:35 -0500
From: Raul Miller <moth@magenta.com>
To: linux-kernel@vger.kernel.org
Subject: guarantee_memory() syscall?
Message-ID: <972824256.eb26eb5e@magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone tell me about the viability of a guarantee_memory() syscall?

[I'm thinking: it would either kill the process, or allocate all virtual
memory needed for its shared libraries, buffers, allocated memory, etc.
Furthermore, it would render this process immune to the OOM killer,
unless it allocated further memory.]

Thanks,

-- 
Raul
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
