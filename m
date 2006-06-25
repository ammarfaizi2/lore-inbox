Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWFYJif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWFYJif (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWFYJif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:38:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:58459 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932215AbWFYJie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:38:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=cDoQ+06wYqmfoIovwD0bzyjnAmwZWwBCUwE7aDh/1/vRhXhdM/BFj2L+M108E5EiaJC++nyPT1JzksJN7uTPcqdw89qjO1G+wlb9DtQD7pVmzJL/HHoGT1MOjoBPBimPkr3yv1wzI8CX9kQb6TPnF4YINtJ05jy15PIgKkcz4Lc=
Date: Sun, 25 Jun 2006 11:38:26 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Darren Reed <darrenr@reed.wattle.id.au>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: spinlock problem
Message-ID: <20060625093826.GC1181@slug>
References: <Pine.LNX.4.61.0606231331310.16810@chaos.analogic.com> <200606240247.k5O2lU3C009083@firewall.reed.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606240247.k5O2lU3C009083@firewall.reed.wattle.id.au>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 12:47:30PM +1000, Darren Reed wrote:
> I believe I'm hitting a race condition of sorts...I just don't know
> who owns it yet - vmware or linux and I cant test running linux
> natively at present because I only have one computer.
> 
You could try ruuning your code in QEMU http://fabrice.bellard.free.fr/qemu/, 
that would help indentifying the culprit.

Regards,
Frederik
