Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264981AbSJPJEw>; Wed, 16 Oct 2002 05:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264982AbSJPJEw>; Wed, 16 Oct 2002 05:04:52 -0400
Received: from mail.zmailer.org ([62.240.94.4]:41366 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S264981AbSJPJEw>;
	Wed, 16 Oct 2002 05:04:52 -0400
Date: Wed, 16 Oct 2002 12:10:46 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile(2) behaviour has changed ?
Message-ID: <20021016091046.GD9644@mea-ext.zmailer.org>
References: <20021016084908.GA770@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016084908.GA770@gemtek.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 10:49:08AM +0200, Zilvinas Valinskas wrote:
> This sample code copies a file using sendfile(2) call works just fine on 
> 2.2.x and 2.4.x kernels. On 2.5.x kernels (not sure starting which
> version) it stopped working. Program terminates with EINVAL error. 
>
> $ ./sendfile
> sendfile: Invalid argument
> 
> Is this expected behaviour ? that sendfile(2) on 2.5.4x linux kernel requires
> socket as an output fd paramter ? 

  It has only been intended for output to a TCP stream socket.

> Was it ever legal to copy file(s) on filesystem using sendfile(2) ?
> (which was kindda nice feature ... )

  No.  It was a nice misfeature.

/Matti Aarnio
