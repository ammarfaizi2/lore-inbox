Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbSKVJMN>; Fri, 22 Nov 2002 04:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267181AbSKVJMN>; Fri, 22 Nov 2002 04:12:13 -0500
Received: from boden.synopsys.com ([204.176.20.19]:50909 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S267179AbSKVJML>; Fri, 22 Nov 2002 04:12:11 -0500
Date: Fri, 22 Nov 2002 10:18:22 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: davids@webmaster.com
Cc: Nivedita Singhvi <niv@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: TCP memory pressure question
Message-ID: <20021122091822.GD16412@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <3DDD8811.752CA2C4@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD8811.752CA2C4@us.ibm.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 05:27:45PM -0800, Nivedita Singhvi wrote:
> > When a Linux machine has reached the tcp_mem limit, what will happen to 
> > 'write's on non-blocking sockets? Will they block until more TCP memory is 
> > available? Will they return an error code? ENOMEM?
> > 
> > If it varies by kernel version, details about different versions would be 
> > extremely helpful. I'm most interested in late 2.4 kernels.
> > 
> >  Thanks in advance.
> Returns EAGAIN.
> Fairly static ~late 2.4.

returns number of bytes sent and sets errno to EAGAIN.

-alex
