Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129715AbQKSLKy>; Sun, 19 Nov 2000 06:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129895AbQKSLKo>; Sun, 19 Nov 2000 06:10:44 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:3369 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129715AbQKSLK3>; Sun, 19 Nov 2000 06:10:29 -0500
Message-ID: <3A17AE15.AC51AA8A@linux.com>
Date: Sun, 19 Nov 2000 02:40:21 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: neighbour table?
In-Reply-To: <Pine.LNX.4.21.0011190158480.3036-100000@blue.cdf.utoronto.ca> <3A1779D9.409FB87B@linux.com> <m1ofzc4d82.fsf@frodo.biederman.org>
Content-Type: multipart/mixed;
 boundary="------------CE4B6E28800F23D012EF0410"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CE4B6E28800F23D012EF0410
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Eric W. Biederman" wrote:

> > Be sure lo is established before eth0 and you won't see this message.
>
> Hmm.  How does the interaction work.  I've been meaning to track it for
> a while but haven't yet.
>
> >From the cases I have observed it seems to be connected with arp requests
> that aren't answered. (I.e when something is misconfigured and you try to nfsroot off
> of the wrong ip on your subnet)
> And I keep thinking neighbour table underflow would have been a better message.

I'm not sure, I'm repeating what Alexey (iirc) has said in the past.  I've been
there/done that and sure enough making sure 'lo' is brought up first prevents that
message.  As to the NFS, no idea, I've never messed w/ nfsroot.

-d


--------------CE4B6E28800F23D012EF0410
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------CE4B6E28800F23D012EF0410--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
