Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSJWRMF>; Wed, 23 Oct 2002 13:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265100AbSJWRMF>; Wed, 23 Oct 2002 13:12:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:5350 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265102AbSJWRMD>;
	Wed, 23 Oct 2002 13:12:03 -0400
Message-ID: <3DB6D877.3D5489DA@us.ibm.com>
Date: Wed, 23 Oct 2002 10:12:23 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       "David S. Miller" <davem@rth.ninka.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
References: <200210231218.18733.roy@karlsbakk.net> <20021023130101.GA646@outpost.ds9a.nl> <1035379308.5950.3.camel@rth.ninka.net> <200210231542.48673.roy@karlsbakk.net> <20021023170102.GA5302@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> I still refuse to believe that a 1.8GHz Pentium4 can only checksum
> 250megabits/second. MD Raid5 does better and they probably don't use a
> checksum as braindead as that used by TCP.
> 
> If the checksumming is not the problem, the copying is, which would be a
> weakness of your hardware. The function profiled does both the copying and
> the checksumming.

Yep, its not so much the checksumming as the fact that this is
done over each byte of data and copied.

thanks,
Nivedita
