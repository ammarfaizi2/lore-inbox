Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbTBXO1n>; Mon, 24 Feb 2003 09:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTBXO1n>; Mon, 24 Feb 2003 09:27:43 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:8636 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S267126AbTBXO1m>; Mon, 24 Feb 2003 09:27:42 -0500
Date: Mon, 24 Feb 2003 07:37:54 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: tg3 patches needed for 2.4.19/2.4.20
In-Reply-To: <20030224131434.I24600@pc9391.uni-regensburg.de>
Message-ID: <Pine.LNX.4.51.0302240729200.21620@skuld.mtroyal.ab.ca>
References: <20030224131434.I24600@pc9391.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Christian Guggenberger wrote:

> Hi,
> 
> In former days there always had been some problems with broadcom GBit Nics. So 
> I'd like to ask what patches for the tg3 are recommended for production use 
> with 2.4.19/2.4.20.

Hi,
I have created a patch for 2.4.20 for the tg3 driver from Jeff
Garziks and David Millers tg3 1.4c driver which I'm hoping will be
in the next kernel.

The patch is at http://www.hardrock.org/kernel/2.4.20/

Note that because of NAPI the 2.4.20 driver will not work with 2.4.19...

I have been using this driver now for 6 days without a lockup (4 days with
2.4.20 and 2 days before that with 2.4.21-pre4) and it has
been working great.  With the stock 2.4.20 tg3 driver we wouldn't get past
36 hours without a lockup...

Regards
James Bourne

> cheers.
> Christian

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

"There are only 10 types of people in this world: those who
understand binary and those who don't."

