Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWHNJt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWHNJt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWHNJt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:49:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:23833 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932068AbWHNJt2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:49:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o59LYsL40X0KZlOHTkvnKnoAH6Ov8JqxHJo9VIRXiFqQGvBKa8VJwbt+ft4jhoa5s8oAUvVTAeDRtCMs0If2LbY/rGdwFHFgLlgrqXFfmPD+phQ8ruYripBVwZDBdLHfUxuj/I5Stdlg72cK5ZBlt2oSg7C5cGsuE6fNXCsefr8=
Message-ID: <81b0412b0608140249y26ed15e9s25f421f1d360f86d@mail.gmail.com>
Date: Mon, 14 Aug 2006 11:49:26 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: "Alex Riesen" <fork0@users.sourceforge.net>,
       "Nicholas Miell" <nmiell@comcast.net>, "Jeff Garzik" <jeff@garzik.org>,
       keith.packard@intel.com, Linux-kernel@vger.kernel.org,
       "Dirk Hohndel" <dirk.hohndel@intel.com>,
       "Imad Sousou" <imad.sousou@intel.com>
Subject: Re: Announcing free software graphics drivers for Intel i965 chipset
In-Reply-To: <20060811234246.GA16586@steel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155151903.11104.112.camel@neko.keithp.com>
	 <44DACD51.7080607@garzik.org> <1155190917.2349.4.camel@entropy>
	 <81b0412b0608110705y75cd5307vf73dd0b6ee107f81@mail.gmail.com>
	 <1155321063.2522.1.camel@entropy> <20060811234246.GA16586@steel.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/06, Alex Riesen <fork0@t-online.de> wrote:
> Nicholas Miell, Fri, Aug 11, 2006 20:31:03 +0200:
> > > >
> > > > More importantly, where's the source to intel_hal.so?
> > > >
> > >
> > > ...and what'd break if the call to intel_hal_set_content_protection is
> > > omited?
> >
> > Where's that call at?
> >
>
> In XOrg parts, I believe. I don't have that tarbal handy, and there is no
> traces of that symbol anywhere on the driver's pages (not even in git repos)
> anymore.
>

More precisely in i830_driver.c, in the function I830VESASetMode, of the archive
xf86-video-intel-git-master-08092006.tgz.
