Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVHOUvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVHOUvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVHOUvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:51:18 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:6206 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964956AbVHOUvR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:51:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KtXpi3N8yyuYLnp4XoVSh8lFxWRe8RtESQD/XhvHb4X8aBGqC4vrG4K4VCeqIQ/kp/uXSF5WqYkbLVcdzfFZ39Bo546FZebCcT2prqpdjF/gHZkzYW9ZgERrbS1fG6TQbUd68jxDrNADucIkgJqN8MkZc899s0CJOVTxD4BU5sQ=
Message-ID: <4789af9e050815135169a76799@mail.gmail.com>
Date: Mon, 15 Aug 2005 14:51:16 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
To: yhlu <yhlu.kernel@gmail.com>
Subject: Re: Atyfb questions and issues
Cc: James Simmons <jsimmons@infradead.org>,
       =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>,
       alex.kern@gmx.de, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <86802c440508151339790da3b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
	 <Pine.LNX.4.56.0508121848040.30829@pentafluge.infradead.org>
	 <86802c4405081211153ec42f7e@mail.gmail.com>
	 <Pine.LNX.4.56.0508151741510.7300@pentafluge.infradead.org>
	 <86802c440508151339790da3b2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, yhlu <yhlu.kernel@gmail.com> wrote:
> last year some time, I have manually the patch from 2.4 to 2.6. my
> patch result is the same as 2.4. It only works when bios doesn't do
> the init. Then if the BIOS do the init, it will hang there. I assume
> something only can be done once.

That is exactly what I did in my proposed patch, attached earlier.

I noticed the same problem.

Does anyone out there know how you can tell if the RageXL chip has
already been initialized?

One test I have that works on my hardware is to test the STAT0
register.  If it ends with 0x95, the chip has not been initialized,
otherwise I initialize it.

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
