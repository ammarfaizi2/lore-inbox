Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVKGPum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVKGPum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVKGPum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:50:42 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:28393 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964830AbVKGPul convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:50:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JCaFYCQH1rDvtJKgdWNSon0UExmhdBMh8pg8JSpC53+Oc2HM9qxaPpk3xxNMS7W3AGVnMIBx0Gr6Ds5XA5PYyLd8u+VIEe1jkZHMMSe01KsFvYByIWBFDnyw71AD0ZhsED35ZzgB6FmeFJDHqrfHNFSJvusLPodhpaj9BMKvDtY=
Message-ID: <4240b9160511070750t25fab9e2u3c8e2c1414b55ebf@mail.gmail.com>
Date: Mon, 7 Nov 2005 16:50:39 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: 3D video card recommendations
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.11.07.14.50.56.126577@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
	 <20051107125513.GD3726@localhost.localdomain>
	 <pan.2005.11.07.14.50.56.126577@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Ville Syrjälä <syrjala@sci.fi> wrote:
> On Mon, 07 Nov 2005 12:55:13 +0000, Hugo Mills wrote:
>
> > On Mon, Nov 07, 2005 at 07:42:51AM -0500, Steven Rostedt wrote:
> >> On Mon, 2005-11-07 at 08:42 +0100, Arjan van de Ven wrote:
> >>
> >> > people who buy a 3D card for linux that depends on a closed source
> >> > module take a few risks, and they should be aware of them (I suspect
> >> > they are) so let me make some of them explicit:
> >>
> >> Are there good 3D cards that don't depend on a proprietary module, that
> >> can run on a AMD64 board?  That was pretty much my questing to begin
> >> with :)
> >
> >    http://www.xgitech.com/
> >
> >    Not the fastest pieces of hardware out there by some way, but they
> > _do_ have open-source drivers.
>
> That's not entirely true. The DRI driver is closed source.
>

DRI closed source ? You mean the fglrx driver from ati ?

Anyway my advice would be to look at dri project an
see the supported card list. http://dri.freedesktop.org
if you want a card with open source 3d driver.

ATI & Intel graphics chipset seems to have the best
open source support i am aware of. For ATI the r300/r400
(radeon 9500-9800/ X300-X800) support is still
experimental (IIRC there are PCI-E issues).

best,
Jerome Glisse
