Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751944AbWCFHXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbWCFHXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCFHXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:23:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:20414 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751944AbWCFHXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:23:48 -0500
Date: Mon, 6 Mar 2006 07:23:46 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, ericvh@gmail.com,
       rminnich@lanl.gov
Subject: Re: 9pfs double kfree
Message-ID: <20060306072346.GF27946@ftp.linux.org.uk>
References: <20060306070456.GA16478@redhat.com> <20060305.230711.06026976.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305.230711.06026976.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 11:07:11PM -0800, David S. Miller wrote:
> From: Dave Jones <davej@redhat.com>
> Date: Mon, 6 Mar 2006 02:04:58 -0500
> 
> > (I wish we had a kfree variant that NULL'd the target when it was free'd)
> 
> Excellent idea.

ITYM "poison the pointer variable".  Otherwise that sort of crap will go
unnoticed.
