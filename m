Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130871AbQLCIMB>; Sun, 3 Dec 2000 03:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130897AbQLCILk>; Sun, 3 Dec 2000 03:11:40 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:7947 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130871AbQLCILj>;
	Sun, 3 Dec 2000 03:11:39 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012030741.eB37f1X116720@saturn.cs.uml.edu>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
To: hpa@zytor.com (H. Peter Anvin)
Date: Sun, 3 Dec 2000 02:41:00 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <90cs81$6vv$1@cesium.transmeta.com> from "H. Peter Anvin" at Dec 02, 2000 11:20:33 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

>> Yeah, people write annoying little wrapper functions that
>> bounce right back into the kernel until the job gets done.
>> This is slow, it adds both source and object bloat, and it
>> is a source of extra bugs. What a lovely API, eh?
>>
>> The fix: write_write_write_damnit() and read_read_read_damnit(),
>> which go until they hit a fatal error or complete the job.
>
> RTFM(fwrite), RTFM(fread).

Those sure look like "annoying little wrapper functions that
bounce right back into the kernel until the job gets done".

They don't even operate directly on file descriptors.
Actually they look like they come from VMS... records???
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
