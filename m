Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264899AbRFTPSY>; Wed, 20 Jun 2001 11:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264898AbRFTPSO>; Wed, 20 Jun 2001 11:18:14 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:3080 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S264899AbRFTPSE> convert rfc822-to-8bit; Wed, 20 Jun 2001 11:18:04 -0400
X-Server-Uuid: 7edb479a-fd89-11d2-9a77-0090273cd58c
From: "Nathan D. Fabian" <ndfabia@sandia.gov>
Organization: Sandia National Laboratories
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] swapfile.c
Date: Wed, 20 Jun 2001 09:16:10 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <01061918242500.00988@sphinx>
In-Reply-To: <01061918242500.00988@sphinx>
MIME-Version: 1.0
Message-ID: <01062009161001.01031@sphinx>
X-Filter-Version: 1.3 (sass165)
X-WSS-ID: 172E6123459677-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 June 2001 06:24 pm, Nathan D. Fabian wrote:
> The following diff tries to improve on the efficiency of try_to_unuse(). 
> It removes the potential O(|swap_map|^2) business and makes it linear time.
> I'm not sure what this means in terms of overall change, but Linus seemed
> interested in the innefficiency in that code.  Test with caution.

I suppose I should mention that this is against a vanilla 2.4.5 kernel, but 
should patches cleanly against 2.4.5-ac16.

