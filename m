Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVCaAht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVCaAht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVCaAf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:35:27 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:50644 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262693AbVCaAes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:34:48 -0500
Date: Wed, 30 Mar 2005 16:34:37 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Pau Aliagas <linuxnow@newtral.org>
Cc: Andi Kleen <ak@muc.de>, linux kernel <linux-kernel@vger.kernel.org>,
       binutils@sources.redhat.com
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050331003437.GB19573@lucon.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org> <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org> <20050330040017.GA29523@lucon.org> <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org> <20050330210801.GA15384@lucon.org> <Pine.LNX.4.62.0503310015490.7060@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503310015490.7060@pau.intranet.ct>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 12:18:55AM +0200, Pau Aliagas wrote:
> On Wed, 30 Mar 2005, H. J. Lu wrote:
> 
> >On Wed, Mar 30, 2005 at 07:57:28AM -0800, Linus Torvalds wrote:
> 
> >>>There is no such an instruction of "movl %ds,(%eax)". The old assembler
> >>>accepts it and turns it into "movw %ds,(%eax)".
> >>
> >>I disagree. Violently. As does the old assembler, which does not turn
> >>"mov" into "movw" as you say. AT ALL.
> >
> >I should have made myself clear. By "movw %ds,(%eax)", I meant:
> >
> >	8c 18	movw   %ds,(%eax)
> >
> >That is what the assembler generates, and should have generated, for
> >"movw %ds,(%eax)" since Nov. 4, 2004.
> 
> Could this be the reason for the reported slowdown in the last six months?
> 

Can you elaborate?


H.J.
