Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVAaWBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVAaWBC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVAaWBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:01:02 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:42200 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261390AbVAaWA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:00:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t4gMKOGrRK8jtlgfhgHsYYnTSwwT2vtGrL+3SXX43883g1OTaK9iwjOgC3jkXcGwyniQtFNcHIN0XKFa2CFOfqRumTvSuUYMu3UyiVbclx6J4z1r/OoifbmEMyw0cVGP6peWAamOVmcwhbt3GNrD/CpJGtW3XNBTR0ORA1+atDM=
Message-ID: <d120d500050131140031f8ee1f@mail.gmail.com>
Date: Mon, 31 Jan 2005 17:00:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       petero2@telia.com
In-Reply-To: <20050131134608.7021ac84@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501251155.20430.david-b@pacbell.net>
	 <d120d50005012513304ba0ca88@mail.gmail.com>
	 <20050131134608.7021ac84@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 13:46:08 -0800, Pete Zaitcev <zaitcev@redhat.com> wrote:
> 
> Can you tell me exactly how I go about "trying out Synaptics X driver"?
> 

Peter's page is here:
http://web.telia.com/~u89404340/touchpad/

Just do "yum update synaptics" and then Adjust your xorg.conf to use
"synaptics" driver. Start with the defaults as shown in the doc
directory. I recommend setting protocol to "auto-dev". Make sure both
psmouse and evdev are loaded.

-- 
Dmitry
