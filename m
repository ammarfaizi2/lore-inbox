Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVGVRvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVGVRvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 13:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVGVRvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 13:51:52 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:29791 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262121AbVGVRvv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 13:51:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y57wjd3se+Y4VXeExHJo1fA7KOW64YQFMnBgxClL/wlwPt9T0xS1VyFYYx6Q13hDCqhY+dV8+WUHw+l0H1tOCmn46PLpHBgTPLBwJYXpi8gsJFQtoCJruWyvsSX8MC5G+1MoN/sDb2QOUyl8PZF0tpb6OLl7TwffvOloRrbPj4o=
Message-ID: <9a87484905072210511ccf377f@mail.gmail.com>
Date: Fri, 22 Jul 2005 19:51:49 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Patrick Draper <pdraper@gmail.com>
Subject: Re: kernel guide to space
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6981e08b050722101241ba2f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050711145616.GA22936@mellanox.co.il>
	 <9a87484905072005596f2c2b51@mail.gmail.com>
	 <m3pstd2jfu.fsf@defiant.localdomain>
	 <6981e08b050722101241ba2f3e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/05, Patrick Draper <pdraper@gmail.com> wrote:
> Why isn't a code formatting program used? 

There's  scripts/Lindent  (which is just a wrapper around indent with
appropriate options.

>People could write the code
> as they like to write it, then format it automatically in a standard
> way before it gets put into the kernel.
> 
You can do some cleanup that way, but not everything, and then if
people continue to write in their own FunkyStyle locally but what's in
the kernel has been beautified they are going to have a hell of a time
creating proper patches...   It should just be cleaned up by whoever
submits it before it gets merged (and if you want to let a tool help
you out some of the way, then noone's stopping you).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
