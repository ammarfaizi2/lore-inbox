Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTIZMRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTIZMPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:15:12 -0400
Received: from ptb-mailc05.plus.net ([212.159.14.211]:5893 "EHLO
	ptb-mailc05.plus.net") by vger.kernel.org with ESMTP
	id S262074AbTIZMOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:14:51 -0400
Date: Fri, 26 Sep 2003 13:15:35 +0100
From: Chris Sykes <chris@spackhandychoptubes.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic on 2.4.22 (no TSC) when compiled for i486
Message-ID: <20030926121535.GB16991@spackhandychoptubes.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030926084848.GA16991@spackhandychoptubes.co.uk> <16244.9644.70305.752172@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16244.9644.70305.752172@gargle.gargle.HOWL>
x-gpg-fingerprint: 1D0A 139D DDA3 F02F 6FC0  B2CA CBC6 5EC0 540A F377
x-gpg-key: wwwkeys.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 01:40:28PM +0200, Mikael Pettersson wrote:
> system which triggers when you change an option which has
> derived options.
> 
> In this case, when first configuring for a CPU with TSC the
> derived CONFIG_X86_TSC option is added. Then when reconfiguring
> for a TSC-less CPU (e.g., 486) the derived option stays because
> it derived from something that _was_ defined at the start of the
> config run.
> 
> The workaround is to do an additional 'make oldconfig', after
> which the derived option will be gone.

OK.  Thanks for the info.

-- 

(o-  Chris Sykes  -- GPG Key: http://www.sigsegv.plus.com/key.txt
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt

