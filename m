Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313689AbSDEXIC>; Fri, 5 Apr 2002 18:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313690AbSDEXHw>; Fri, 5 Apr 2002 18:07:52 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:64251 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S313689AbSDEXHf>; Fri, 5 Apr 2002 18:07:35 -0500
Date: Fri, 5 Apr 2002 18:07:35 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Itai Nahshon <nahshon@actcom.co.il>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Morton <akpm@zip.com.au>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020405180735.E15540@redhat.com>
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu> <200204052302.g35N2o516910@lmail.actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 02:02:36AM +0300, Itai Nahshon wrote:
> A required feature IMHO: there should _never_ be dirty blocks
> for disks that are not spinning.

Never make assertions like that: on my laptop, I want *lots* of 
dirty blocks held in memory while the disk isn't spinning.  Keeping 
RAM powered is much less costly than spinning the disk up.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
