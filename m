Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280570AbRKJSUq>; Sat, 10 Nov 2001 13:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280583AbRKJSUh>; Sat, 10 Nov 2001 13:20:37 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:63331 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280570AbRKJSU0>; Sat, 10 Nov 2001 13:20:26 -0500
Date: Sat, 10 Nov 2001 05:25:54 +0000
From: Stephen Tweedie <sct@redhat.com>
To: Robert Lowery <Robert.Lowery@colorbus.com.au>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Assertion failure wth ext3 on standard Redhat 7.2 kernel
Message-ID: <20011110052554.A21643@redhat.com>
In-Reply-To: <370747DEFD89D2119AFD00C0F017E66150B29A@cbus613-server4.colorbus.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <370747DEFD89D2119AFD00C0F017E66150B29A@cbus613-server4.colorbus.com.au>; from Robert.Lowery@colorbus.com.au on Fri, Nov 09, 2001 at 05:20:58PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 09, 2001 at 05:20:58PM +1100, Robert Lowery wrote:
 
> The last error I get is
> Assertion failure in __journal_file_buffer() at transaction.c:1953:

It's usually the _first_, not the last, error which is most revealing.
Did /var/log/messages capture anything more about the earlier errors?

Cheers,
 Stephen
