Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbRBAORr>; Thu, 1 Feb 2001 09:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129918AbRBAOR1>; Thu, 1 Feb 2001 09:17:27 -0500
Received: from p3EE3CA62.dip.t-dialin.net ([62.227.202.98]:54023 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129170AbRBAORU> convert rfc822-to-8bit; Thu, 1 Feb 2001 09:17:20 -0500
Date: Thu, 1 Feb 2001 15:17:17 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: What does "NAT: dropping untracked packet" mean?
Message-ID: <20010201151717.D5706@emma1.emma.line.org>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010201133811.D14768@ipe.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010201133811.D14768@ipe.uni-stuttgart.de>; from nils@ipe.uni-stuttgart.de on Thu, Feb 01, 2001 at 13:38:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Feb 2001, Nils Rennebarth wrote:

> Since enabling (but not yet using) firewalling in the 2.4.1 kernel, my log
> gets clobbered with messages like:
> 
> Feb  1 12:58:56 obelix kernel: NAT: 0 dropping untracked packet ce767600 1 129.69.22.21 -> 224.0.0.2
> 
> The IP Adresses belong to Windows 98 computers. What does the message mean,
> and what could I do to stop them?

It means that your box drops multicast administrative packets on the
floor.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
