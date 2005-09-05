Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVIET3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVIET3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVIET3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:29:04 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:20882 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932396AbVIET3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:29:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=uuTcvEBXMnfoqypwfr9TWD3oUiaLaElkvww5VEw9LGlVhMpw9nkFtEeW2oy/ymlsAwEAKfvihtCnfVG6padG6D5d5tf2Ey6B+fDwC6ge3M+JoDKIIAtM6uWH07IGWVSx8uSw8W2t/DrovAVOqD0duQzQJlX4Vwn6T8HhCwWZbfg=
Date: Mon, 5 Sep 2005 23:38:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Corey Minyard <minyard@acm.org>, viro@zeniv.linux.org.uk,
       Matt_Domsch@dell.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFLART] ipmi procfs bogosity
Message-ID: <20050905193845.GA6449@mipter.zuzino.mipt.ru>
References: <20050901064313.GB26264@ZenIV.linux.org.uk> <43175DEC.4000600@acm.org> <20050901203043.GB10893@mipter.zuzino.mipt.ru> <200509051251.41928.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509051251.41928.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 12:51:32PM +0200, Ingo Oeser wrote:
> I would suggest adding sth. like Coreys user_strtoul()

strtoul_from_user

> to lib/string.c

lib/vsprintf.c

> which would reduce bloat and security threats for the kernel.

