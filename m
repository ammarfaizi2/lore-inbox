Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWATQKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWATQKw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWATQKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:10:52 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28549
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750846AbWATQKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:10:51 -0500
Date: Fri, 20 Jan 2006 08:10:44 -0800
From: Greg KH <gregkh@suse.de>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       rmk@arm.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH]-jsm driver fix for linux-2.6.16-rc1
Message-ID: <20060120161044.GA26249@suse.de>
References: <43D1099E.3050509@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D1099E.3050509@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 10:02:38AM -0600, V. Ananda Krishnan wrote:
> @@ -20,8 +20,11 @@
>   *
>   * Contact Information:
>   * Scott H Kilau <Scott_Kilau@digi.com>
> - * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
> - *
> + * Wendy Xiong   <wendyx>

That's not an email address, why not just fix Wendy's to be correct, or
drop it if that's not the person to contact?

> +        /*
> +         * If the DONT_FLIP flag is on, don't flush our buffer, and act

Wrong code indentation, use tabs please.  This is in a number of places
in the patch.

thanks,

greg k-h
