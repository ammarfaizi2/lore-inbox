Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVCBOYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVCBOYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVCBOYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:24:48 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:24810 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262309AbVCBOYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:24:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IEn9DKkSam3AgK/8WFFZKKjd2Ay1Ct5thy6qGN2zPLR4ZMzGC2Iih5hlyHtZs9atDwkgzJ6RjzXR3VUZX0kVaPCUEx63EciQ2VYs3vZH3W75qEWxJPnBGPJyUQxGlsjUVk6lZgNNizV0+NaW7T2kD+vyEZ0bjVKvJJKpOUGxvH0=
Message-ID: <d120d500050302062451cc2af3@mail.gmail.com>
Date: Wed, 2 Mar 2005 09:24:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Subject: Re: [PATCH] raw1394 missing failure handling
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4225B167.3030903@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42259F3A.8000206@mech.kuleuven.ac.be>
	 <1109763232.12379.6.camel@imp.csi.cam.ac.uk>
	 <4225B167.3030903@mech.kuleuven.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 13:28:23 +0100, Panagiotis Issaris
<panagiotis.issaris@mech.kuleuven.ac.be> wrote:
> Hi,
> 
> Anton Altaparmakov wrote:
> 
> >On Wed, 2005-03-02 at 12:10 +0100, Panagiotis Issaris wrote:
> >
> >
> >>In the raw1394 driver the failure handling for
> >>a __copy_to_user call is missing.
> >>
> >>
> >
> >Your patch is obviously incorrect as it doesn't free the request before
> >it returns.
> >
> >
> Oops. Thanks for replying! Any more problems with the updated
> patch?
> 

Formatting... Opening curly brace should go on the same line with "if".

-- 
Dmitry
