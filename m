Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWBFVWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWBFVWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWBFVWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:22:41 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:7443 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932118AbWBFVWl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:22:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GITM+rp3AlhYK+rVwwLebXyDXymNdlvpse76hrjxjmhUQrJVhRR1LPL+hJjsllHN/kMIm1KUzKzlTgLOR65bXIWSH2vjxDPPDjpNtBVD7lKn/3s8h2Fn4n6oxkItqf8xQ5kBC2M/7aP399w10YqhaykHcOP1w9Pe+ldFQgJBzkQ=
Message-ID: <12c511ca0602061322s7e97c488r78f14cd4897621f0@mail.gmail.com>
Date: Mon, 6 Feb 2006 13:22:40 -0800
From: Tony Luck <tony.luck@intel.com>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 1/3] NEW VERSION: *at syscalls: Implementation
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       kenneth.w.chen@intel.com
In-Reply-To: <12c511ca0602061226pf3bf095jcc570754656c5437@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512171742.jBHHgAKh018491@devserv.devel.redhat.com>
	 <12c511ca0602061226pf3bf095jcc570754656c5437@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm, setuid too!

Ignore this bit ... I had been messing with the mode argument and forgot
to "rm xxx" between one test and the next.  But I still can't get sys_mkdirat()
to make a directory ... I just get a regular file.

-Tony
