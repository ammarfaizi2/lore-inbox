Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVIMQNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVIMQNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVIMQNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:13:33 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:43534 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964837AbVIMQNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:13:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=YD2Y0OGiqxdFKs1H756X4PaqGDmuM+5uOyfGEmM8tdaQ1BY8dGy8jl5HxV8BRfzuWKI5/aPJn6BblbnIF62c2b60AJWGl5oYRVUdc7/zG47mWq47z2TsRNrKFqT5YweGPzazPvz82/IDQy1oI/az379a30yodiJgkIuZ/GMVxdw=
Date: Tue, 13 Sep 2005 20:23:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 brings buffer underruns when burning DVDs at high speeds (16x)
Message-ID: <20050913162340.GA24000@mipter.zuzino.mipt.ru>
References: <1126527113.2169.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126527113.2169.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 02:11:53PM +0200, Mathieu Fluhr wrote:
> It seems that something has been broken when passing from 2.6.12 to
> 2.6.13 regarding the SCSI burning engine. When burning a DVD at 16x
> (with ide-cd SEND_PACKET command, or with the SG interface, no matter
> the driver used), you get tons of buffer underruns. This was not
> appearing in 2.6.12.

I've filed a bug at kernel bugzilla, so your report won't be lost. See
http://bugme.osdl.org/show_bug.cgi?id=5242

Please, register at http://bugme.osdl.org/createaccount.cgi and add
yourself to bug's CC list.

