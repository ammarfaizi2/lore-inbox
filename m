Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUEVIoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUEVIoP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUEVIoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:44:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9420 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264920AbUEVIoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:44:10 -0400
Date: Sat, 22 May 2004 10:43:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext3 barrier bits
Message-ID: <20040522084357.GT1952@suse.de>
References: <20040521093207.GA1952@suse.de> <20040521023807.0de63c7a.akpm@osdl.org> <20040521100234.GK1952@suse.de> <20040521235044.6160cccb.akpm@osdl.org> <20040522073540.GO1952@suse.de> <20040522011139.01a7da10.akpm@osdl.org> <1085214261.2781.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085214261.2781.1.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22 2004, Arjan van de Ven wrote:
> 
> > - Does the kernel tell you if your disk doesn't supoprt barriers?  ie:
> >   how does the user know if it's working or not?
> 
> ... and how do you know your disk isn't lying and ignoring the barriers?

Easy to find out, time it. Or invent more imaginative cases where you
actually test if it's there.

-- 
Jens Axboe

