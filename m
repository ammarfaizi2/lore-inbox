Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWAHXl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWAHXl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 18:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161250AbWAHXl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 18:41:26 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:56262 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161248AbWAHXlZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 18:41:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HsgFhGHYrPV8QEBjhBnDDAeZGIv54uNQWP2LgKU7eO/oik3m4ArDqI2ROzWb5zQ0vCjfLOkOqxZJF/DCmsxtsmThWOjdsBiWMhLdCeX3GRGENuEomaH3KMSAUzNWXWiLU5XrlS82qxu0qc5uRdWhO4Ae3Xlc/hGCYBuA3TmeWm4=
Message-ID: <a01a16b50601081541n582fb3e2k2b7b7fb3494330e2@mail.gmail.com>
Date: Mon, 9 Jan 2006 00:41:21 +0100
From: =?ISO-8859-1?Q?H=E5kon_L=F8vdal?= <hlovdal@gmail.com>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: MODULE_VERSION useless? (was Re: [KJ] adding missing MODULE_* stuffs)
In-Reply-To: <200601081855.17723.carlos@embedded.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20051230000400.GS18040@outflux.net>
	 <20060108204549.GB5864@mipter.zuzino.mipt.ru>
	 <200601081855.17723.carlos@embedded.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/06, Carlos Manuel Duclos Vergara <carlos@embedded.cl> wrote:
> Hi everyone,
>
> I have two ideas about what to do with MODULE_VERSION:
> 1.- Defining MODULE_VERSION = KERNEL_VERSION
> 2.- Schedule it for removal in one or two more versions, and automagically use
> the KERNEL_VERSION as module's version.
>
> Any comments?

I think there is another option:

3. Always print KERNEL_VERSION in addition to MODULE_VERSION.

Since for some modules MODULE_VERSION is considered useful and
KERNEL_VERSION always is useful, this should give the best of both, right?

BR Håkon Løvdal
