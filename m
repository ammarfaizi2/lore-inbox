Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVCaBxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVCaBxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVCaBxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:53:12 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54680 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262390AbVCaBxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:53:09 -0500
Date: Wed, 30 Mar 2005 17:52:57 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Pau Aliagas <linuxnow@newtral.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>,
       binutils@sources.redhat.com
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050331015257.GB20979@lucon.org>
References: <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org> <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org> <20050330040017.GA29523@lucon.org> <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org> <20050330210801.GA15384@lucon.org> <Pine.LNX.4.62.0503310015490.7060@pau.intranet.ct> <20050331003437.GB19573@lucon.org> <Pine.LNX.4.62.0503310253180.7060@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503310253180.7060@pau.intranet.ct>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 02:57:57AM +0200, Pau Aliagas wrote:
> On Wed, 30 Mar 2005, H. J. Lu wrote:
> 
> >>>That is what the assembler generates, and should have generated, for
> >>>"movw %ds,(%eax)" since Nov. 4, 2004.
> >>
> >>Could this be the reason for the reported slowdown in the last six months?
> >
> >Can you elaborate?
> 
> There's an unexplained slowdown of kernel 2.6 detailed in this thread:
> http://kerneltrap.org/node/4940
> 

It is dated as "November 13, 2002 - 13:58". The assembler change was
made on Nov. 4, 2004. I don't think they are related at all.

> I don't want at all to justify it with the change you talk about in gas, 
> but maybe it is worth to check if it has anything to do with it. The 
> slowdown happened in this last six months.


H.J.
