Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbQLEUjP>; Tue, 5 Dec 2000 15:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129985AbQLEUjG>; Tue, 5 Dec 2000 15:39:06 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:6415 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129371AbQLEUiu>;
	Tue, 5 Dec 2000 15:38:50 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012052007.eB5K7RK436972@saturn.cs.uml.edu>
Subject: Re: Using map_user_kiobuf()
To: cw@f00f.org (Chris Wedgwood)
Date: Tue, 5 Dec 2000 15:07:26 -0500 (EST)
Cc: linux@procom.demon.co.uk (John Meikle),
        sct@redhat.com (Stephen C. Tweedie),
        linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <20001206030850.A4661@metastasis.f00f.org> from "Chris Wedgwood" at Dec 06, 2000 03:08:50 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Am I the only one who finds the READ/WRITE option back to front?
>     
> No, I was just thinking it should be change to USER_READ, USER_WRITE
> or something a little more obvious. 

Eh, read data from userspace and write data to userspace? Oops.

FROM_USER
TO_USER

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
