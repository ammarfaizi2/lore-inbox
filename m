Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131539AbRACWLs>; Wed, 3 Jan 2001 17:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131533AbRACWLj>; Wed, 3 Jan 2001 17:11:39 -0500
Received: from mnh-1-13.mv.com ([207.22.10.45]:65288 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S130111AbRACWLH>;
	Wed, 3 Jan 2001 17:11:07 -0500
Message-Id: <200101032320.SAA03593@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Dan Aloni <karrde@callisto.yi.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug 
 exploits
In-Reply-To: Your message of "Wed, 03 Jan 2001 23:13:31 +0200."
             <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jan 2001 18:20:39 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

karrde@callisto.yi.org said:
> This preliminary, small patch prevents execution of system calls which
> were executed from a writable segment. It was tested and seems to
> work, without breaking anything. It also reports of such calls by
> using printk.

Have you tried running UML on this kernel?

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
