Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267242AbUGVUhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267242AbUGVUhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUGVUhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:37:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267242AbUGVUhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:37:51 -0400
Date: Thu, 22 Jul 2004 16:34:55 -0400
From: Alan Cox <alan@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: Willy Tarreau <willy@w.ods.org>, solar@openwall.com,
       tigran@aivazian.fsnet.co.uk, alan@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
Message-ID: <20040722203455.GA26526@devserv.devel.redhat.com>
References: <20040707234852.GA8297@openwall.com> <Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet> <20040718125925.GA20133@openwall.com> <20040718212721.GC1545@alpha.home.local> <20040718161549.5c61d4a9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040718161549.5c61d4a9.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 04:15:49PM -0700, Paul Jackson wrote:
> The setuidapp will see the shell's memory.  In general, a app, setuid or
> not, should make no assumption that any open fd's handed to it at birth
> were opened using the same priviledges that the app itself has.


Now think about "exec suidapp < ..." thats more fun

