Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129791AbRBTPKj>; Tue, 20 Feb 2001 10:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRBTPK3>; Tue, 20 Feb 2001 10:10:29 -0500
Received: from t2.redhat.com ([199.183.24.243]:43769 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129791AbRBTPKU>; Tue, 20 Feb 2001 10:10:20 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.30.0102192146380.7008-100000@ferret.lmh.ox.ac.uk> 
In-Reply-To: <Pine.LNX.4.30.0102192146380.7008-100000@ferret.lmh.ox.ac.uk> 
To: Chris Evans <chris@scary.beasts.org>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Feb 2001 15:09:33 +0000
Message-ID: <23164.982681773@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


chris@scary.beasts.org said:
>  I think the proper fix, long term, is to fix our internal I/O routine
> APIs so that they are capable of returning a byte count _and_ an
> error. One day, that might be a useful thing to export to userspace. 

The MTD code already does this. 

--
dwmw2


