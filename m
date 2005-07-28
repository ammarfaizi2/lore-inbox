Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVG1VQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVG1VQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVG1VOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:14:41 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:17867 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262319AbVG1VMf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:12:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CKVchPeYREM3dhtLe+EQVLlHEkkjTQ3lmUZBw4iB77Zru/DwGNqRL8mey2UYeJp5Q38i9BYn31U2G2ndh1fIae1j1lijLMlF1bl5Dt4e1RvO5buHt/ifbp0Ne9pzJnDc0RIcIfk4deQpjO5xeQ8qAH3jMxc2Vac3Y23qQuXA2Fs=
Message-ID: <9e47339105072814125d0901d9@mail.gmail.com>
Date: Thu, 28 Jul 2005 17:12:34 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Greg KH <greg@kroah.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org
In-Reply-To: <200507282310.23152.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726015401.GA25015@kroah.com>
	 <20050728190352.GA29092@kroah.com>
	 <9e47339105072812575e567531@mail.gmail.com>
	 <200507282310.23152.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Oliver Neukum <oliver@neukum.org> wrote:
> Am Donnerstag, 28. Juli 2005 21:57 schrieb Jon Smirl:
> > New, simplified version of the sysfs whitespace strip patch...
> 
> Could you tell me why you don't just fail the operation if malformed
> input is supplied?

Leading/trailing white space should be allowed. For example echo
appends '\n' unless you know to use -n. It is easier to fix the kernel
than to teach everyone to use -n.

> 
>         Regards
>                 Oliver
> 


-- 
Jon Smirl
jonsmirl@gmail.com
