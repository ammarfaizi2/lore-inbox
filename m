Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRCBJ5a>; Fri, 2 Mar 2001 04:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130384AbRCBJ5U>; Fri, 2 Mar 2001 04:57:20 -0500
Received: from oxmail1.ox.ac.uk ([129.67.1.1]:47036 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S130383AbRCBJ5D>;
	Fri, 2 Mar 2001 04:57:03 -0500
Date: Fri, 2 Mar 2001 09:57:02 +0000
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: ftruncate not extending files?
Message-ID: <20010302095701.A4685@sable.ox.ac.uk>
In-Reply-To: <Pine.LNX.4.30.0103011502050.23650-100000@swamp.bayern.net> <E14YXft-0008GK-00@the-village.bc.nu> <20010302084544.A26070@home.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010302084544.A26070@home.ds9a.nl>; from ahu@ds9a.nl on Fri, Mar 02, 2001 at 08:45:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert writes:
> I would've sworn, based on the fact that I saw people do it, that ftruncate
> was a legitimate way to extend a file

Well it's not SuSv2 standards compliant:

    http://www.opengroup.org/onlinepubs/007908799/xsh/ftruncate.html

    If the file previously was larger than length, the extra data is
    discarded. If it was previously shorter than length, it is
    unspecified whether the file is changed or its size increased. If
    ^^^^^^^^^^^
    the file is extended, the extended area appears as if it were
    zero-filled.

How "legitimate" relates to "SuSv2 standards compliant" is your call.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
