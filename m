Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVGGODT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVGGODT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVGGOBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:01:25 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:27047 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261555AbVGGN7M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:59:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AKbn9KJ8lRFjUhKeEUa+RpjmjpdKzbkBJXOY23s8OyWc2+Qv9zzsmNgz5md9fOaUDbxJAciOHDm1eGjkYaSCEdRnCnyoKFBUhkboL2HS5/i0kTjNrOBnevNYZXA8I0ejqniRAQLW7+boTwjBOzviVpxJVZqpG1DxPbs/TbxEcuU=
Message-ID: <9e473391050707065942e7f651@mail.gmail.com>
Date: Thu, 7 Jul 2005 09:59:10 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: 2.6.13-rc2 hangs at boot
Cc: Tero Roponen <teanropo@cc.jyu.fi>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050707135928.A3314@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
	 <9e47339105070618273dfb6ff8@mail.gmail.com>
	 <20050707135928.A3314@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialized end = 0 fixed me.

On 7/7/05, Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
> On Wed, Jul 06, 2005 at 09:27:11PM -0400, Jon Smirl wrote:
> > I'm dead on a Dell PE400SC without reverting this.
> 
> Jon, can you try this one instead:
> http://lkml.org/lkml/2005/7/6/273
> 
> If it doesn't help, I'd like to see 'lspci -vv' from your machine.
> 
> Ivan.
> 


-- 
Jon Smirl
jonsmirl@gmail.com
