Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVEJWUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVEJWUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEJWUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:20:24 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:12868 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261843AbVEJWUH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:20:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sz+FfDEEKWYevdy2a87vqmKyP/28gPcfsUbZGwfUgyUrTBNqRzimMBaKuBiZrZh5IEPRrw9nkFIxsHg9QEniUp+p19jAq072ai6qwCs2jJIZPr9CFgPfLAbXmg+cRPCo6BzeyEd/kvfcXx6RVkn1wW6AECnqQdLQCsgER9vly+Y=
Message-ID: <d120d5000505101520ad1761@mail.gmail.com>
Date: Tue, 10 May 2005 17:20:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: ALPS touchpad issues still exist in 2.6.12-rc4
Cc: linux-kernel@vger.kernel.org, Alan Lake <alan.lake@lakeinfoworks.com>,
       petero2@telia.co.uk, vojtech@suse.cz, stuart@zeus.com
In-Reply-To: <42812E89.4070301@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42801AEE.5080308@lakeinfoworks.com>
	 <200505092305.45788.dtor_core@ameritech.net>
	 <42812E89.4070301@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Daniel Drake <dsd@gentoo.org> wrote:
> Hi,
> 
> Dmitry Torokhov wrote:
> > Do you have an ALPS touchpad? Try applying Peter Osterlund's patches
> > from here:
> >
> > http://web.telia.com/~u89404340/patches/touchpad/2.6.11/
> 
> Even with these patches applied, some Gentoo users are still reporting
> problems with ALPS touchpads. Are there any suggested solutions for
> http://bugzilla.kernel.org/show_bug.cgi?id=4281 ?

For tap-and-drag support and to control topuchpad's sensitivity you
would need to install Synaptics X driver (and/or updated GPM with
evedev support).

-- 
Dmitry
