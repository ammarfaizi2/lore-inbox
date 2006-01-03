Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWACLYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWACLYT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWACLYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:24:19 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:53958 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750862AbWACLYS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:24:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mdYtlIuV0VMMLIW2Zs7liJSe/X40AJHBWiVqJeVberjc8l/evs3aNf1woqTrHuFD+GpJnhuH+5hw0joh6S0+0vM1gOXrU6yu40wNns2f54zHcId1brQnrZNZk/DaCDXjyXJd4EdM1pXsa7YhhqC+3LI7dSuYjEulJ2wa/rsPBjo=
Message-ID: <21d7e9970601030324h5dd7beeap42be94c46d0aa6e0@mail.gmail.com>
Date: Tue, 3 Jan 2006 22:24:16 +1100
From: Dave Airlie <airlied@gmail.com>
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Subject: Re: [2.6.14.5] iounmap: bad address
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43B3C2C3.1070201@labri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B3C2C3.1070201@labri.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I am running a 2.6.14.5 on a Transmeta Crusoe laptop (Vaio PCG-C1MZ) and
> I'm having some troubles with the iounmap function. Each time I'm
> shutting down the machine or even just stopping the gdm daemon, I got
> the following error log:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7655f493b74f3048c02458bc32cd0b144f7b394f

is the fix for this, and my latest DRM tree remove the is_pci flag completly....

Or at least I hope that is the fix for it..

Dave.
