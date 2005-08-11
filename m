Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVHKKAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVHKKAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 06:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVHKKAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 06:00:37 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:58757 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964829AbVHKKAh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 06:00:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aSUG8fLPkiL7j1ry/mrR8/N0Ugmx9LLML2wwCtobMhupwB0MjfEPkhEbUdli9Kr1CzlCvcuGgTjqX97mFVcPlZvCufBqgowxVQlzkTmL1o9ez4XAvxJ8/zG4A7X9q6P5jeXvpymlRKQVXGI0yPiBAEKrswv0iFtGdD3dVODEvPk=
Message-ID: <84144f0205081103003cf4fbe7@mail.gmail.com>
Date: Thu, 11 Aug 2005 13:00:35 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Michael <mikore.li@gmail.com>
Subject: Re: [Linux-cluster] GFS - updated patches
Cc: linux clustering <linux-cluster@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <bc57270905081102545e9555c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050802071828.GA11217@redhat.com>
	 <20050811081729.GB12438@redhat.com>
	 <bc57270905081102545e9555c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, Michael <mikore.li@gmail.com> wrote:
> Hi, Dave,
> 
> I quickly applied gfs2 and dlm patches in kernel 2.6.12.2, it passed
> compiling but has some warning log, see attachment. maybe helpful to
> you.

kzalloc is not in Linus' tree yet. Try with 2.6.13-rc5-mm1.

                                 Pekka
