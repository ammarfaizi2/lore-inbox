Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136669AbRECKYL>; Thu, 3 May 2001 06:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136677AbRECKYA>; Thu, 3 May 2001 06:24:00 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:29968 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S136669AbRECKXu>; Thu, 3 May 2001 06:23:50 -0400
Date: Thu, 3 May 2001 22:23:47 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Message-ID: <20010503222347.A26495@metastasis.f00f.org>
In-Reply-To: <20010503205754.A26313@metastasis.f00f.org> <E14vFjM-0005Gx-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14vFjM-0005Gx-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 03, 2001 at 10:49:02AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 10:49:02AM +0100, Alan Cox wrote:

    No collisions. There are other good reasons you dont want to do
    forks on files that way (you need to enumerate them but if you
    make them directories all hell breaks loose).

Hmm... so how else do you support n-forks cleanly preserving existing
semantics? I'm not sure I like Linus' suggestion, but I can't think
of anything better.



 --cw

(On the whole, I think forks are horrible enough that we shouldn't
 encourage them further than we do already with .AppleDouble, and
 similar solutions... but, opinions vary greatly here)
