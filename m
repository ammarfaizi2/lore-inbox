Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVDBB5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVDBB5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVDBB5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:57:44 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:6379 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262970AbVDBBwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:52:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=AHvWyXm+CeNHQbX2cpNEZYeohhSIMvf9VCudg1fTZRQsEguhZqGvbIh8+AqT3bylcBmPbAlDMMxslz171GHEpnMjqlP/nHdMczC+Zo/w15rPm8goB2gMsu90gYX+ZA/743J0TIXjDJ6avbuMRgdUwKjYBnYshAg5lEOmw804jW8=
Date: Fri, 1 Apr 2005 20:52:29 -0500
To: Noah Silverman <noah@allresearch.com>
Cc: Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org
Subject: Re: Hangcheck problem
Message-ID: <20050402015228.GA13364@zion.rivenstone.net>
Mail-Followup-To: Noah Silverman <noah@allresearch.com>,
	Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org
References: <424B0FF7.4090601@allresearch.com> <Pine.LNX.4.62.0503301709530.1159@morpheus> <424B2859.1070704@allresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B2859.1070704@allresearch.com>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 02:29:45PM -0800, Noah Silverman wrote:
> On Wed, 30 Mar 2005, Noah Silverman wrote:

> > I'm been experiencing a weird problem....
> >
> > I get endlessly repeated hangcheck errors in my syslog with no
> explanation:
> >
> > Mar 30 12:41:43 db kernel: Hangcheck: hangcheck value past margin!

> Burton Windle wrote:
> > Kernel version?
> > 
> 
> 2.6.7

    That's a really old kernel, and I'm sure anyone who could look
into this will ask you to upgrade to something recent and reproduce it
as the first step in tracking it down.

    Is this an older box?  I've seen the hangcheck warnings on a
486 I was using as a firewall/router -- ultimately I applied a patch
to set HZ to 100 and the problem went away.  I *think*, once that patch
bitrotted, that I just turned off the hangcheck timer, but I can't
remember for sure.

   If you turn off the hangcheck timer, does the problem go away
(i.e. no more lockups)?

-- 
Joseph Fannin
jfannin@gmail.com
