Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUJRQe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUJRQe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUJRQe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:34:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:36303 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266838AbUJRQe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:34:56 -0400
Date: Mon, 18 Oct 2004 09:33:46 -0700
From: Greg KH <greg@kroah.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Lee Revell <rlrevell@joe-job.com>,
       David Woodhouse <dwmw2@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       gene.heskett@verizon.net, Linux kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041018163346.GB18169@kroah.com>
References: <200410151153.08527.gene.heskett@verizon.net> <1097857049.29988.29.camel@weaponx.rchland.ibm.com> <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com> <1097860121.13633.358.camel@hades.cambridge.redhat.com> <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com> <1097873791.5119.10.camel@krustophenia.net> <20041015211809.GA27783@kroah.com> <4170426E.5070108@nortelnetworks.com> <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com> <Pine.LNX.4.61.0410180845040.3512@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410180845040.3512@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 08:53:46AM -0400, Richard B. Johnson wrote:
> +/*
> + *  List of acceptable module-license strings.
> + */
> +static const char *licok[]= {
> +    "GPL",
> +    "GPL v2",
> +    "CPL and additional rights",

The CPL is very different from the GPL and the two are not compatible,
so this isn't an acceptable patch.

thanks,

greg k-h
