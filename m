Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264612AbRFYUiU>; Mon, 25 Jun 2001 16:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265914AbRFYUiL>; Mon, 25 Jun 2001 16:38:11 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:62656 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264612AbRFYUh6>; Mon, 25 Jun 2001 16:37:58 -0400
Date: Mon, 25 Jun 2001 19:42:13 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ext3-users@redhat.com
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>,
        Florian Lohoff <flo@rfc822.org>
Subject: Re: Oops in iput
Message-ID: <20010625194213.J18856@redhat.com>
In-Reply-To: <20010625201612.A701@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010625201612.A701@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Jun 25, 2001 at 08:16:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 25, 2001 at 08:16:12PM +0200, Florian Lohoff wrote:
> 
> oops in iput - Kernel 2.2.19/i386 + ide-udma patches + ext3 patches (0.0.7a)

The ide-udma patches for 2.2 haven't had nearly the testing of the 2.4
ones, and simply can't be trusted as a baseline for debugging other
code.  Can you reproduce this problem without them applied?  The oops
here is a networking oops on the face of it, and I wouldn't expect to
see that on 2.2 unless something was corrupting memory.

Cheers,
 Stephen
