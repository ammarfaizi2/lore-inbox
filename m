Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbUKVXNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUKVXNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUKVXKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:10:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:14046 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261865AbUKVXJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:09:34 -0500
Date: Mon, 22 Nov 2004 15:05:33 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Message-ID: <20041122230533.GB13083@kroah.com>
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com> <20041122714.AyIOvRY195EGFTaO@topspin.com> <20041122225335.GE15634@kroah.com> <52sm71bie2.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52sm71bie2.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 02:58:45PM -0800, Roland Dreier wrote:
>     Greg> Why do you propose such a "deep" nesting of directories for
>     Greg> umad devices?  That's not the LANNANA way.
> 
> No real reason, I'm open to better suggestions.

/dev/umad* 
/dev/ib/umad*

>     Greg> Oh, have you asked for a real major number to be reserved
>     Greg> for umad?
> 
> No, I think we're fine with a dynamic major.  Is there any reason to
> want a real major?

People who do not use udev will not like you.

thanks,

greg k-h
