Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135567AbRAGBsk>; Sat, 6 Jan 2001 20:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135566AbRAGBsb>; Sat, 6 Jan 2001 20:48:31 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:55812
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S135520AbRAGBsW>; Sat, 6 Jan 2001 20:48:22 -0500
Date: Sun, 7 Jan 2001 14:48:19 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Sourav Ghosh <sourav@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Speed of the network card
Message-ID: <20010107144819.B1617@metastasis.f00f.org>
In-Reply-To: <3A57C442.C3AE831@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A57C442.C3AE831@cs.cmu.edu>; from sourav@cs.cmu.edu on Sat, Jan 06, 2001 at 08:20:02PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 08:20:02PM -0500, Sourav Ghosh wrote:

    I was wondering how I can determine the speed of a network device
    inside the kernel.

what kind of network card?
    
    In case of ethernet, the "name" field  of device structure will
    only give eth0 or something. But the speed could be either 10Mbps
    or 100Mbps.

we don't have a good was on doing this sort of thing, you could try
mii-tool though; it supports many cards



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
