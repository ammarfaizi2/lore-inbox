Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWDESoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWDESoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWDESoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:44:15 -0400
Received: from wproxy.gmail.com ([64.233.184.234]:36549 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751325AbWDESoO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:44:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hjiewva7dgyhDjAuJwKtxu5ra/k+yF6u2Pk16k9j5kADegpFbUFGRyvvYDtP76bv9oWZHHO5IgGsTjfro6//zIDv47TGGbMDKAaqSOpHjl5Rf6GDyM+7tMrxcrr+DIO0HQDqu9Xgw72fBxkQsZ9rs2hwUnD6tSm4n9VRALaBgtY=
Message-ID: <d120d5000604051144r535e1b5k763269f1f5ef17ea@mail.gmail.com>
Date: Wed, 5 Apr 2006 14:44:13 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Rene Herman" <rene.herman@keyaccess.nl>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Cc: "Greg KH" <gregkh@suse.de>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <44340E12.9000202@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44238489.8090402@keyaccess.nl> <4432EF58.1060502@keyaccess.nl>
	 <44330DFA.4080106@keyaccess.nl>
	 <200604042145.24685.dtor_core@ameritech.net>
	 <44340E12.9000202@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/06, Rene Herman <rene.herman@keyaccess.nl> wrote:
> Dmitry Torokhov wrote:
>
> >> Well, we could in fact hang an unregister off device->private_data as
> >> per attached example. Wouldn't be _excessively_ ugly. Still sucks
> >> though.
> >
> > Plus it broke all the drivers that create platform devices before
> > registering drivers or the ones simply not using private data.
>
> No, this was just a suggestion for an ALSA specific workaround. I was
> suggesting ALSA drivers could do this.
>

Yes, I am sorry - I misread the code snipped as if it was in driver
core, not in ALSA itself.

--
Dmitry
