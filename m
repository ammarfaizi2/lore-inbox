Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313162AbSDYT5f>; Thu, 25 Apr 2002 15:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313339AbSDYT5e>; Thu, 25 Apr 2002 15:57:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16915 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313162AbSDYT5d>;
	Thu, 25 Apr 2002 15:57:33 -0400
Message-ID: <3CC85F74.4EA986E5@zip.com.au>
Date: Thu, 25 Apr 2002 12:56:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <OFA8584441.22F71259-ON85256B9F.00627FAA@pok.ibm.com> <20020425194346.GN574@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> ...
> Is the BIO max size going to change at different offsets?

Yes, it is.

And as far as I know, that size is in all cases calculable
before the top-level assembly begins.

-
