Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVITOVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVITOVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVITOVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:21:54 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:59761 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932758AbVITOVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:21:53 -0400
Date: Tue, 20 Sep 2005 17:25:09 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: workaround large MTU and N-order allocation failures
Message-ID: <20050920142509.GA26617@localdomain>
References: <20050918143526.GA24181@localdomain> <20050918230822.GA5440@electric-eye.fr.zoreil.com> <20050919071358.GA7107@localdomain> <5fc59ff305091910252447d363@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc59ff305091910252447d363@mail.gmail.com>
User-Agent: Mutt/1.5.10i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 10:25:29AM -0700, Ganesh Venkatesan wrote:
> 82546GB supports an incoming Rx packet to be received in multiple rx
> buffers. A driver that enables this feature is under test currently.
> What version of the e1000 are you using?

We are currently using the lastest version of the driver from the 2.6 
tree backported to the 2.4 tree. I wasn't aware that 82546GB supports 
this - I inferred differently from the comments in the driver's source.

Is the version of the driver you mention available from CVS somewhere?

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
