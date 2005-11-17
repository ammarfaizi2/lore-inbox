Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVKQNW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVKQNW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVKQNW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:22:57 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:8480 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750812AbVKQNW5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:22:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eySM0Gff1qSxLyDt9i6uAGYC8k76MnQe79ijneVdgIeaw2jPkRb153MpO58olHr8SLryx0k16oaatO/wBzBnYMZJVQHwtYoMradMoQFGL5gFuIBm96yiPbUDzXOrJR3YRD8CQ5qosOlB0/PNR1KXcfoBBxO1Bj+dIIofU0J/wJs=
Message-ID: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com>
Date: Thu, 17 Nov 2005 13:22:55 +0000
From: Bradley Chapman <kakadu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too have been experiencing some problems with laptop-mode that may
be similar to what was recently reported here.

I have a Centrino machine (Sager NP3760, aka Clevo M375E) with a 60GB
Hitachi TravelStar hard disk running in UDMA5 and 512MB RAM, and on
occassions I've had random files on my /usr partition overwritten and
both my /usr and /var filesystems quite thoroughly trashed - with
these events usually occuring right after I'd been on battery power
and my hard disk had been spinning up and down regularly.

All my filesystems are ext3 with journaling active, and none of them
have been messed with (i.e. resized).

Brad
--
SCREW THE ADS! http://adblock.mozdev.org/
