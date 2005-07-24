Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVGXCwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVGXCwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 22:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVGXCwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 22:52:24 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:39965 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261839AbVGXCwX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 22:52:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eEwAA9IAxT0wJTufjnSuVRoLbfuzITwREJDDu4nNLKXgBRAoUYWSAFCmYholD3c5tuZ+5Hi2U3uxV32IA3ZzLiRVwgBcmy9tv4XC04b5OojO2jhxQa+pWU397wpUAs1NCoFnosK4RzjJLP9TRIw5qAwNwoe5b5AgLE2cuyY9Yl8=
Message-ID: <9871ee5f05072319523528f2de@mail.gmail.com>
Date: Sat, 23 Jul 2005 22:52:21 -0400
From: Timothy Miller <theosib@gmail.com>
Reply-To: Timothy Miller <theosib@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: HELP: NFS mount hangs when attempting to copy file
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1122135532.8203.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9871ee5f050720155671cbc376@mail.gmail.com>
	 <1122135532.8203.5.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/05, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> I beg to disagree. A lot of these VPN solutions are unfriendly to MTU
> path discovery over UDP. Sun uses TCP by default when mounting NFS
> partitions. Have you tried this on your Linux box?

I changed the protocol to TCP and changed rsize and wsize to 1024.  I
don't know which of those fixed it, but I'm going to leave it for now.

As for MTU, yeah, the Watchguard box seems to have some hard-coded
limits, and for whatever reason KDE and GNOME graphical logins do
something that exceeds those limits, completely independent of NFS,
and hang up hard.

Thanks.
