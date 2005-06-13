Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFMTDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFMTDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFMTDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:03:07 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:45416 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261222AbVFMTAE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:00:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=psEd0G0YY/2zhRhkWr7bCpc3zcHXtMcZgNjVrn8XM0WGe7UMkVsLhk8ceZzYFb+EcK+ojukj2GnLV1ak4BLjIPsjiJbAvz7ucS0FZuS3E348rI4xh7THwyxj8TZcPO75USYto7kwS+W23wh9rsDuTXPAIGJVo2PFqnDoASLlaII=
Message-ID: <9a87484905061312004b2b91e8@mail.gmail.com>
Date: Mon, 13 Jun 2005 21:00:02 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark Bidewell <mark.bidewell@alumni.clemson.edu>
Subject: Re: kernel 2.6.11.12 I2C error
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42ADD458.3090906@alumni.clemson.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42ADD458.3090906@alumni.clemson.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/05, Mark Bidewell <mark.bidewell@alumni.clemson.edu> wrote:
> When I attempt to compile 2.6.11.12 from a full download. I get the
> following messages:
> 
> include/linux/i2c.h:58: error: array type has incomplete element type
> include/linux/i2c.h:197: error: array type has incomplete element type
> 
> I think the problem has to do with the forward declartion used in those
> lines.
> 
> I am using gcc 4.0 on FC4 final
> 
Try an older gcc or a recent gcc snapshot. gcc 4.0 has known issues
when compiling the kernel.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
