Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276764AbRJBWv0>; Tue, 2 Oct 2001 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276758AbRJBWvP>; Tue, 2 Oct 2001 18:51:15 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:56573 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276764AbRJBWvB>; Tue, 2 Oct 2001 18:51:01 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 2 Oct 2001 16:50:22 -0600
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: System reset on Kernel 2.4.10
Message-ID: <20011002165022.T8954@turbolinux.com>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <527872464EC@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527872464EC@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2001  23:02 +0000, Petr Vandrovec wrote:
> but nobody bothers with checking error value, it even tries it
> to use as an offset if stars are in wrong constellation.
> If you could add these lines below the call:
> 
> if ((unsigned long)error >= (unsigned long)(-256)) {

What's wrong with IS_ERR(error)?

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

