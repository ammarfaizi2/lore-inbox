Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSDMRCh>; Sat, 13 Apr 2002 13:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292666AbSDMRCg>; Sat, 13 Apr 2002 13:02:36 -0400
Received: from h52544c185a20.ne.client2.attbi.com ([24.147.41.41]:28170 "EHLO
	luna.pizzashack.org") by vger.kernel.org with ESMTP
	id <S290797AbSDMRCe>; Sat, 13 Apr 2002 13:02:34 -0400
Date: Sat, 13 Apr 2002 13:02:33 -0400
From: xystrus <xystrus@haxm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: link() security
Message-ID: <20020413130233.A4743@pizzashack.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020411181524.A1463@figure1.int.wirex.com> <E16wQsU-0000cb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 05:59:54PM +0100, Alan Cox wrote:
> > http://openwall.com.  Work based on Solar Designer's Openwall patch has
> > been brought forward to more recent 2.4 and 2.5 kernels.  Both the
> > following projects implement the Openwall secure link feature:
> > 
> >   http://grsecurity.net
> >   http://lsm.immunix.org
> > 
> > This can break some applications that make assumptions wrt. link(2)
> > (Courier MTA for example).
> 
> How practical is it to make this a mount option and to do so cleanly ?

Perhaps two options: one to allow creation of the link only when the
UIDs match; and the other to allow the link when GIDs match, to keep
Courier happy?

