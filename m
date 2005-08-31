Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVHaNwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVHaNwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVHaNwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:52:50 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:44920 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932515AbVHaNwt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:52:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dW6/8ciE+seYoE/XC48G6HyDBnv4gFMumCsFCVO4Kr7SZkEpSQvPcW+KuZasi156wNwr+Et3+9E8eted5tt4DBvGDi+0n3JTTRV0X9A7TH+Wnug6sTt8FmrTWqj0ZPYC7nmrv8Q9QlJ3onxZEKvzOMAbq2iMpKUEQ0n9OHQnwvA=
Message-ID: <84144f0205083106522e5db06c@mail.gmail.com>
Date: Wed, 31 Aug 2005 16:52:48 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <4315AACF.2050409@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
	 <874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp>
	 <84144f0205083103142faaf076@mail.gmail.com>
	 <4315AACF.2050409@sm.sony.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> > Please consider moving this check to callers. Conditional allocation
> > makes this bit strange API-wise. Or alternatively, give
> > hint_allocate() a better name.
> 
> How about hint_allocate_conditional() ?

hint_get() sounds better to me.

                        Pekka
