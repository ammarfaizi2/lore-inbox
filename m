Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129818AbRAOKPl>; Mon, 15 Jan 2001 05:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130225AbRAOKPb>; Mon, 15 Jan 2001 05:15:31 -0500
Received: from p3EE3CA64.dip.t-dialin.net ([62.227.202.100]:31748 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129999AbRAOKPT>; Mon, 15 Jan 2001 05:15:19 -0500
Date: Mon, 15 Jan 2001 11:15:16 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010115111516.D3981@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101121649220.8097-100000@penguin.transmeta.com> <Pine.LNX.3.95.1010112165949.1292b-100000@scsoftware.sc-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010112165949.1292b-100000@scsoftware.sc-software.com>; from kerndev@sc-software.com on Fri, Jan 12, 2001 at 17:09:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, John Heil wrote:

> I then changed to the 80 wire cables and retried with only -d1 again, 
> and to my surprise, the problems never came back and DMA stayed on.
> A while later, I added -X66 and it too worked great. Then lastly came
> the re-add of the rest giving current state.

Yuck. What UDMA mode does your kernel put the drive in at boot WITHOUT
the -X option? -X66 means UDMA 2 (33).

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
