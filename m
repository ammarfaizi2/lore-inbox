Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292035AbSBAU6y>; Fri, 1 Feb 2002 15:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292032AbSBAU6k>; Fri, 1 Feb 2002 15:58:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60933 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292028AbSBAU5t>;
	Fri, 1 Feb 2002 15:57:49 -0500
Message-ID: <3C5B012B.FE72EFD1@zip.com.au>
Date: Fri, 01 Feb 2002 12:57:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ricardo Galli <gallir@uib.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au>,
		<3C5AFE2D.95A3C02E@zip.com.au> <E16Wkcm-0005D4-00@antoli.uib.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli wrote:
> 
> > ext2 is the only filesystem which has O_DIRECT support.
> 
> Does that mean that the succesful test with ext3 and 2.4.14 is bogus?
> 

Yep.  O_DIRECT was added around 2.4.10, was tugged out for a while
and then went back in again.

-
