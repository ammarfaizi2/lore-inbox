Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVGUSuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVGUSuD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 14:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVGUSuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 14:50:03 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:41599 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261841AbVGUSuA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 14:50:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WpZdUzCB56q+O+0HVkobS/0Xwfj/ihameQncMxBteGo+ifaar/s5iYHGXZPuHLJjKY47qcG4rvTs52fN5GiVMDwltbouBbP+AJvsyrfLXyzQLdK69dg/IguaIJfmfsbLKoPLfrQdIZzOtoIOsIKz48jUVK81JMKvkx+uLlSYZAs=
Message-ID: <3d8471ca05072111494b45ffe8@mail.gmail.com>
Date: Thu, 21 Jul 2005 20:49:59 +0200
From: Guillaume Chazarain <guichaz@gmail.com>
Reply-To: Guillaume Chazarain <guichaz@gmail.com>
To: Voluspa <lista1@telia.com>
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050721200448.5c4a2ea0.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050721200448.5c4a2ea0.lista1@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/21, Voluspa <lista1@telia.com>:
> 
> 2h48m at 100 HZ
> 2h48m at 250 HZ
> 2h47m at 1000 HZ

Now, what would be interesting is to see if the lack of differences
comes from the fact that the processor has enough time to sleep,
not enough time, or simply it does not matter.

That is, is it a best case or a worst case ?

> #!/bin/sh
> touch time-hz-start
> while (true) do
>     touch time-hz-end
>     sleep 1m
> done

Why this ?
Why not simply nothing ?
A computer can be idle for more than 1 minute ;-)

-- 
Guillaume
