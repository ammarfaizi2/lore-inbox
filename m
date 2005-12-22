Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVLVX4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVLVX4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVLVX4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:56:18 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:40721 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751139AbVLVX4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:56:18 -0500
Message-ID: <43AB3D15.2030303@shadowen.org>
Date: Thu, 22 Dec 2005 23:56:05 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] pci device ensure sysdata initialised
References: <20051220151609.565160d9.akpm@osdl.org> <20051222210628.GA16797@shadowen.org> <20051222231843.GB1943@kroah.com> <43AB3A1C.5070606@shadowen.org> <20051222235101.GA2826@kroah.com>
In-Reply-To: <20051222235101.GA2826@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Well, why not properly locate them?  That's my point :)
> 
> It seems you just put a default sysdata on a few places in the tree,
> which fixed your boot problems.  I'm thinking that isn't fixing the root
> issue here of not probing the pci devices properly on these boxes.  Does
> that make more sense?

I was thinking of doing that as a separate patch for the platforms I
have access to.  But most of the hardcoded places are special cases for
rather obscure hardware.

More tommorrow.

-apw
