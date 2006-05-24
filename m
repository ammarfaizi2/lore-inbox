Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWEXHi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWEXHi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbWEXHi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:38:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:45581 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932644AbWEXHi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:38:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nHuh9V6syjh26/7ez2whYT5YkQtxEprfeaWwzzHD4dL5Sz4Oijw95bU0qusy5d7IHljiz6WK1FbFeP7etXySnfq3xWM0CEAdJQFChew7HvjwE7eNsjR/3F+X3h6X+aIt8MhSXWdyuwHK1eiOYUidSxDQIvD6Kjfssu4me6VgsPo=
Message-ID: <84144f020605240038g643501c6p57aa4bb9805ed5d6@mail.gmail.com>
Date: Wed, 24 May 2006 10:38:27 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "James Lamanna" <jlamanna@gmail.com>
Subject: Re: [OOPS] amrestore dies in kmem_cache_free 2.6.16.18 - cannot restore backups!
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aa4c40ff0605231824j55c998c3oe427dec2404afba0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aa4c40ff0605231824j55c998c3oe427dec2404afba0@mail.gmail.com>
X-Google-Sender-Auth: e8f6e9f44f897ccb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/06, James Lamanna <jlamanna@gmail.com> wrote:
> So I was able to recreate this problem on a vanilla 2.6.16.18 with the
> following oops..
> I'd say this is a serious regression since I cannot restore backups
> anymore (I could with 2.6.14.x, but that kernel series had other
> issues...)
>
> amrestore does manage to read 1 32k block from tape before dying.
>
> Any help would be greatly appreciated.

You could try with CONFIG_DEBUG_SLAB enabled to see if it catches anything.
