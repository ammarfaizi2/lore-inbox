Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276305AbRJKN0o>; Thu, 11 Oct 2001 09:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276309AbRJKN0e>; Thu, 11 Oct 2001 09:26:34 -0400
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:34189 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S276305AbRJKN0Y>;
	Thu, 11 Oct 2001 09:26:24 -0400
Message-ID: <62283.212.247.172.29.1002806753.squirrel@webmail.stesmi.com>
Date: Thu, 11 Oct 2001 15:25:53 +0200 (CEST)
Subject: =?iso-8859-1?Q?Re:_[PATCH]_Re:_Lost_Partition?=
From: "=?iso-8859-1?Q?Stefan_Smietanowski?=" <stesmi@stesmi.com>
To: <viro@math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110110919021.22698-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110110919021.22698-100000@weyl.math.psu.edu>
Cc: <v.sweeney@dexterus.com>, <linux-kernel@vger.kernel.org>
Reply-To: stesmi@stesmi.com
X-Mailer: SquirrelMail (version 1.2.0 [rc1])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Re partition problem.


> -	unsigned long first_sector, first_size, this_sector, this_size;
> +	unsigned long first_sector, this_sector, this_size;

> +	this_size = first_size;


It seems that's sorta wrong, no?

You just removed "first_size" and then you access it :)

// Stefan


