Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135669AbREFNAl>; Sun, 6 May 2001 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135671AbREFNAc>; Sun, 6 May 2001 09:00:32 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:57104 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S135669AbREFNAZ>; Sun, 6 May 2001 09:00:25 -0400
Date: Mon, 7 May 2001 01:00:22 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon possible fixes
Message-ID: <20010507010022.A32198@metastasis.f00f.org>
In-Reply-To: <20010506142346.C31269@metastasis.f00f.org> <E14wO16-00023N-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14wO16-00023N-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, May 06, 2001 at 01:51:59PM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 01:51:59PM +0100, Alan Cox wrote:

    prefetch is virtually addresses. An application would need access
    to /dev/mem or similar. So the only folks I think it might
    actually bite are the Xserver people.

depends, maybe it depends on what part of the northbridge it
traverses, so it may only affect RAM and not PCI/AGP memory

it should be possible to write a test program that uses /dev/mem to
test for this is someone has a buggy MB (or wants to send me one,
I'll gladly do it -- my MBs work perfect it seems)


  --cw
    
    
    
