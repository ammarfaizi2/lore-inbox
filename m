Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276331AbRJKNiP>; Thu, 11 Oct 2001 09:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276330AbRJKNiG>; Thu, 11 Oct 2001 09:38:06 -0400
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:44941 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S276335AbRJKNh5>;
	Thu, 11 Oct 2001 09:37:57 -0400
Message-ID: <62869.212.247.172.29.1002807452.squirrel@webmail.stesmi.com>
Date: Thu, 11 Oct 2001 15:37:32 +0200 (CEST)
Subject: =?iso-8859-1?Q?Re:_Re:_[PATCH]_Re:_Lost_Partition?=
From: "=?iso-8859-1?Q?Stefan_Smietanowski?=" <stesmi@stesmi.com>
To: <viro@math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110110927390.22698-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110110927390.22698-100000@weyl.math.psu.edu>
Cc: <v.sweeney@dexterus.com>, <linux-kernel@vger.kernel.org>
Reply-To: stesmi@stesmi.com
X-Mailer: SquirrelMail (version 1.2.0 [rc1])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

>> Hi. Re partition problem.
>>
>>
>> > -	unsigned long first_sector, first_size, this_sector, this_size;
>> > +	unsigned long first_sector, this_sector, this_size;
>>
>> > +	this_size = first_size;
>>
>>
>> It seems that's sorta wrong, no?
>>
>> You just removed "first_size" and then you access it :)
>
> Look carefully at the arguments list.  first_size had just become
> explicitly passed to extended_partition().

Yeah I see that now. Sorry, didn't look closely enough.

// Stefan



