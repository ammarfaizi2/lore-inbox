Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbRAEMFg>; Fri, 5 Jan 2001 07:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRAEMF0>; Fri, 5 Jan 2001 07:05:26 -0500
Received: from [172.16.18.67] ([172.16.18.67]:59264 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129834AbRAEMFP>; Fri, 5 Jan 2001 07:05:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010105072350.B31025@metastasis.f00f.org> 
In-Reply-To: <20010105072350.B31025@metastasis.f00f.org>  <20010105071053.A31025@metastasis.f00f.org> <Pine.LNX.4.30.0101041813310.967-100000@nvws005.nv.london> 
To: Chris Wedgwood <cw@f00f.org>
Cc: Mo McKinlay <mmckinlay@gnu.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Lang <david.lang@digitalinsight.com>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2001 12:04:40 +0000
Message-ID: <2642.978696280@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cw@f00f.org said:
>  Powering down a VCR whilst recording can damage the tape or even
> worse have the tap get jammed in the video. I have also had a TV die
> because it was unpowered from the mains without being switched off
> first.

> Sure, these things don't always happen -- but they sometimes do. I
> would argue things like VCRs and TVs are just more tolerant than more
> complex systems -- not immune. 

The reasoning here seems to be that because many other systems break under 
these circumstances, we shouldn't bother to make Linux reliable.

I don't quite understand that way of thinking.

I will continue to test the boards I work on with random power cycles and 
to consider the filesystem broken if it doesn't like that treatment.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
