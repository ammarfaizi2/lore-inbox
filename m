Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVKVJqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVKVJqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVKVJqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:46:16 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:37642 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751298AbVKVJqO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:46:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q9lLYeUPTb6WOTt1Jhc65b0q/4FIjwceykTe2Ym0+MIsuf0KBBIF7KDpGvwzKIkg9Cc0VEiuVpbNPn7fqieHH1yUVmhgypOZGPcNemwhHeaM1dvFThKzpCgnhBbO94UUk8KmnuudtWaslkVCrhDY6l1hK5J7TA+7TWJ0xh0iiiY=
Message-ID: <4ad99e050511220146i2fd7d001va55a7ca9daa7188@mail.gmail.com>
Date: Tue, 22 Nov 2005 10:46:13 +0100
From: Lars Roland <lroland@gmail.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: Poor Software RAID-0 performance with 2.6.14.2
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051121204752.GK9488@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
	 <20051121204752.GK9488@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> > dkstorage01:~# hdparm -t /dev/md0
> > /dev/md0:
> >  Timing buffered disk reads:  182 MB in  3.01 seconds =  60.47 MB/sec
> >
> > dkstorage02:~# hdparm -t /dev/hdc1
> > /dev/hdc1:
> > Timing buffered disk reads:  184 MB in  3.02 seconds =  60.93 MB/sec
>
> How about at least testing one of the drives involved in the raid,
> although I assume they are identical in your case given the numbers.

There are four identical drives in the machines although I only stripe
on two of them - I can assure you that I get the same numbers from all
the drives - I should ofcause have put this info in the orig post.

>
> Did you test this with other kernel versions (older ones) to see if it
> was better in the past?

Also tried 2.4.27 and 2.4.30 - no difference there.
