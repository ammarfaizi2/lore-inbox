Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRD1AjI>; Fri, 27 Apr 2001 20:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136283AbRD1Ai6>; Fri, 27 Apr 2001 20:38:58 -0400
Received: from monza.monza.org ([209.102.105.34]:23569 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132607AbRD1Ain>;
	Fri, 27 Apr 2001 20:38:43 -0400
Date: Fri, 27 Apr 2001 17:38:39 -0700
From: Tim Wright <timw@splhi.com>
To: dave.fraser@baesystems.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resetting a PCI device
Message-ID: <20010427173839.A2220@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: dave.fraser@baesystems.com, linux-kernel@vger.kernel.org
In-Reply-To: <001901c0ceff$c0ae88e0$64ccdd89@edinbr.gmav.gecm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <001901c0ceff$c0ae88e0$64ccdd89@edinbr.gmav.gecm.com>; from dave.fraser@baesystems.com on Fri, Apr 27, 2001 at 10:52:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not generally.
Systems that support hot-plug PCI also have the ability to reset individual
PCI slots (ISTR that it's a requirement). Sadly, this facility is not
generally available on "normal" systems.

Tim

On Fri, Apr 27, 2001 at 10:52:20AM +0100, dave.fraser@baesystems.com wrote:
> Is there any way of issuing a PCI reset (safely) without rebooting?  I am
> developing a peripheral device (using a pci card with an FPGA and a plx9080
> pci interface), and find that its local bus is prone to hanging up.  It
> would be nice if I could just reset the entire device via the PCI reset,
> without having to go through the hassle of a reboot.  Is this wishful
> thinking?
> 
> - Dave
> 
> ---------------------------------------------------------------------
>  Dave Fraser
>  Development Engineer
>  BAE Systems, Ferry Road,
>  Edinburgh, EH5 2XS
>  Tel: +44 131 3434729
>  Fax: +44 131 3434124
> ---------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
