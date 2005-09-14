Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVINRzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVINRzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVINRzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:55:04 -0400
Received: from peabody.ximian.com ([130.57.169.10]:34541 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S932314AbVINRzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:55:02 -0400
Subject: Re: [patch] hdaps driver update.
From: Robert Love <rml@novell.com>
To: dtor_core@ameritech.net
Cc: Greg KH <greg@kroah.com>, Mr Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <d120d500050914101436201a71@mail.gmail.com>
References: <1126713453.5738.7.camel@molly>
	 <20050914160527.GA22352@kroah.com> <1126714175.5738.21.camel@molly>
	 <20050914161622.GA22875@kroah.com> <1126715517.5738.35.camel@molly>
	 <d120d500050914101436201a71@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 13:55:36 -0400
Message-Id: <1126720536.5738.36.camel@molly>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 12:14 -0500, Dmitry Torokhov wrote:

> For now. But I could see one changing device structure to create some
> attribute that could keep the object pinned in memory even after
> module is unloaded. It seems that we have settled on the rule that
> driver_unregister waits for the last refrence to drop off but devices
> can live longer.

Sold.

I'll use platform_device_register_simple ().

	Robert Love


