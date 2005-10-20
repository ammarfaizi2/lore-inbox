Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVJTV7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVJTV7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVJTV7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:59:52 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:17047 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932515AbVJTV7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:59:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G3U0KEmsE6PyOV3uS1jyOU//N2Ar2lnWDZAN8zxzdQtb0/8erGYP4ObtcG1WvTH9KDLAJgmPmRcSRhM5X5UuFu8VCKpyoU2j+jUxGtMyHp9B0VqMLG9PNZrUGw7jjTkWtIJ+yMIgD88RLmySKNd9DYjfZePJRZjPafUhhXahb08=
Message-ID: <d120d5000510201459y25a2c8e5v55bf830c445c9dbf@mail.gmail.com>
Date: Thu, 20 Oct 2005 16:59:50 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jonathan Mayer <jonmayer@google.com>
Subject: Re: [PATCH] added sysdev attribute to sysdev show/store methods - for linux-2.6.13.4
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/05, Jonathan Mayer <jonmayer@google.com> wrote:

>  2. it precludes the ability to create sys_device objects whose
> attributes are not known at compile time (such as an sysfs
> representation of the smbios table for some platforms -- which will be
> my next patch submission).
>

Does this smbios table have to be a system device (does it have to be
suspended and resumed with interrupts off) or maybe platform bus suits
it better?

--
Dmitry
