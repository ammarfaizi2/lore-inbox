Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTBKPqk>; Tue, 11 Feb 2003 10:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTBKPqk>; Tue, 11 Feb 2003 10:46:40 -0500
Received: from [213.86.99.237] ([213.86.99.237]:30951 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262469AbTBKPqj>; Tue, 11 Feb 2003 10:46:39 -0500
Subject: Re: mtdblock read only device broken?
From: David Woodhouse <dwmw2@infradead.org>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E48080F.9060209@murphy.dk>
References: <3E48080F.9060209@murphy.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044978975.2263.28.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Feb 2003 15:56:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 20:14, Brian Murphy wrote:
> Is the mtd read only block device broken in general or is it only for 
> mips that it doesn't work?

It was broken during the block device overhaul and nobody bothered to
fix it up. I've now merged my latest code to Marcelo and most of the
changes from Linus' tree back into my own -- I should get round to the
next step of actually sending it to Linus some time in the next few
weeks. 

-- 
dwmw2
