Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVHKItn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVHKItn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 04:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVHKItn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 04:49:43 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:64421 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030226AbVHKItn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 04:49:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DMvF93vzOngZiE7Xqmr9Buz5r2WCD+FI+juVdCZd9wyx0oYG7Kej2K3RS5qRTfY/HhUCVwk+A7SuV4UnevqcE+6/i6Xk6GXhkLxhqgW3IhtLflrSfw7Suo6/bk+lD6Nggj9juCAzmnYQSDaabrjXXA6KN88FVrxQHyU3avz3EvA=
Message-ID: <bc57270905081101495fea825e@mail.gmail.com>
Date: Thu, 11 Aug 2005 16:49:42 +0800
From: Michael <mikore.li@gmail.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: GFS - updated patches
Cc: linux-cluster@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050811084645.GD12438@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050802071828.GA11217@redhat.com>
	 <20050811081729.GB12438@redhat.com>
	 <bc57270905081101217fdd4c5f@mail.gmail.com>
	 <20050811084645.GD12438@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, after apply dlm.patch, I saw it! although I don't know what's "-mm".

Thanks,

Michael

On 8/11/05, David Teigland <teigland@redhat.com> wrote:
> On Thu, Aug 11, 2005 at 04:21:04PM +0800, Michael wrote:
> > I have the same question as I asked before, how can I see GFS in "make
> > menuconfig", after I patch gfs2-full.patch into a 2.6.12.2 kernel?
> 
> You need to select the dlm under drivers.  It's in -mm, or apply
>   http://redhat.com/~teigland/dlm.patch
> 
>
