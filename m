Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265335AbRFVFLE>; Fri, 22 Jun 2001 01:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265337AbRFVFKy>; Fri, 22 Jun 2001 01:10:54 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:12036 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S265335AbRFVFKk>; Fri, 22 Jun 2001 01:10:40 -0400
Date: Fri, 22 Jun 2001 17:10:37 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH: ethtool MII helpers
Message-ID: <20010622171037.D2576@metastasis.f00f.org>
In-Reply-To: <3B23AFC3.71CE2FD2@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B23AFC3.71CE2FD2@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Jun 10, 2001 at 01:34:59PM -0400
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2001 at 01:34:59PM -0400, Jeff Garzik wrote:

    Initial draft of a helper which uses generic elements present in several
    net drivers to implement ethtool ioctl support in a minimum amount of
    code.
    
    I have included a sample implementation in the epic100 driver, to
    illustrate how these helpers may be used.  This should make it easier to
    implement support across 10/100 hardware which uses primarily an MII
    phy.
    
    Comments appreciated.

Can someone explain to me why we have ethtool and mii-tool? Can we
not extend ethtool for the mii-tool stuff, even if only at userland?



  --cw
