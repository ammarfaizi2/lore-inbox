Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbSLNVkU>; Sat, 14 Dec 2002 16:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbSLNVkU>; Sat, 14 Dec 2002 16:40:20 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:24539 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S265982AbSLNVkT>; Sat, 14 Dec 2002 16:40:19 -0500
Date: Sun, 15 Dec 2002 10:28:12 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: James Morris <jmorris@intercode.com.au>, linux-kernel@vger.kernel.org
cc: "David S. Miller" <davem@redhat.com>,
       cryptoapi-devel <cryptoapi-devel@kerneli.org>
Subject: Re: [RFC] Hardware support notes for the kernel crypto API (2.5+)
Message-ID: <9000000.1039901292@localhost.localdomain>
In-Reply-To: <Mutt.LNX.4.44.0212150025190.24712-100000@blackbird.intercode.com.au>
References: <Mutt.LNX.4.44.0212150025190.24712-100000@blackbird.intercode.co
 m.au>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - What will the Kernel & Userspace APIs look like?

A socket family?  Most userspace crypto apps, IMO, will deal with 
networking somewhere.

>   - Asymmetric crypto?

Yes please!  A HiFn 6500 can do a 2048-bit DH exchange in about 30ms, 
compared with several seconds for a P3-900.  It's similarly fast for 
everything else, and utterly astonishing for RSA (under a millisecond for a 
signature!).

>  Intel
>    Crypto documentation for NICs unavailable.

I may have some leverage here.  We'll see.

>   Broadcom
>     No response to emails.

But OpenBSD has drivers, and they say that Broadcom were very good to deal 
with.  I suggest writing the OpenBSD driver maintainer and asking who to 
contact.

Andrew
