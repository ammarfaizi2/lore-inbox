Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267503AbUH1Rya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267503AbUH1Rya (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUH1Rya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:54:30 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:28102 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S267503AbUH1RyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:54:15 -0400
Date: Sat, 28 Aug 2004 10:53:50 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Lee Revell <rlrevell@joe-job.com>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       clemtaylor@comcast.net, qg@biodome.org, rogers@isi.edu
Subject: Re: reverse engineering pwcx
In-Reply-To: <1093710358.8611.22.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0408281039470.16039@twin.uoregon.edu>
References: <1093709838.434.6797.camel@cube> <1093710358.8611.22.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004, Lee Revell wrote:

> Right, as someone else pointed out, this is wrong.
>
> How do you account for the Slashdot poster's assertion that it's
> physically impossible to cram 640 x 480 worth of data down a USB 1.1
> pipe?

640x480 = 307200 pixels
x 24 bits = 7372800 bits per frame (.9MB)
x 30 fps = 221184000

so that's 221mb/s for uncompressed 640x480. dv with 16bit pcm is 25Mb/s 
typically which is still a bit more than double what you can reasonably 
push through a usb1.1 port. raw you can push about 1.6 fp/s at 640x480 
through usb so your compression ratio needs to be order of 15 to 1 make 
it fit reasonably with room for overhead.

> Lee
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

