Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUAWXr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266795AbUAWXr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:47:29 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:44810 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S266793AbUAWXrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:47:23 -0500
Date: Fri, 23 Jan 2004 15:47:18 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Userland headers available
Message-ID: <20040123234718.GF16386@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200401231907.17802.mmazur@kernel.pl> <20040123184755.GA2138@nevyn.them.org> <401172D8.8040507@nortelnetworks.com> <4011788D.3070606@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4011788D.3070606@nortelnetworks.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This space available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 02:39:57PM -0500, Chris Friesen wrote:
> Friesen, Christopher [CAR:7Q28:EXCH] wrote:
> 
> >The obvious way is to have the kernel headers include the userland
> >headers, then everything below that be wrapped in "#ifdef __KERNEL__". 
> >Userland then includes the normal kernel headers, but only gets the 
> >userland-safe ones.
> 
> I just realized this wasn't clear.  I envision a new set of headers in 
> the kernel that are clean to export to userland.  The current headers 
> then include the appropriate userland-clean ones, and everything below 
> that is kernel only.
> 
> This lets the kernel maintain the userland-clean headers explicitly, and 
> we don't have the work of cleaning them up for glibc.

This gets discussed every few months.  I think the most
recent was in August.

http://groups.google.com/groups?q=linux-kernel+include/abi&hl=en&lr=&ie=UTF-8&selm=lXHU.431.1%40gated-at.bofh.it&rnum=1

	(google linux-kernel include/abi)

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
