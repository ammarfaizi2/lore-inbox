Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVCNU1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVCNU1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVCNU0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:26:08 -0500
Received: from coderock.org ([193.77.147.115]:3293 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261859AbVCNUYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:24:16 -0500
Date: Mon, 14 Mar 2005 21:24:08 +0100
From: Domen Puncer <domen@coderock.org>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 1/5] drivers/serial/jsm: new serial device driver
Message-ID: <20050314202408.GD3955@nd47.coderock.org>
References: <20050308064424.GF17022@kroah.com> <422DF525.8030606@us.ltcfwd.linux.ibm.com> <20050308235807.GA11807@kroah.com> <422F1A8A.4000106@us.ltcfwd.linux.ibm.com> <20050309163518.GC25079@kroah.com> <422F2FDD.4050908@us.ltcfwd.linux.ibm.com> <20050309185800.GA27268@kroah.com> <4231B972.5070203@us.ltcfwd.linux.ibm.com> <20050312130637.GA8272@nd47.coderock.org> <4235CB5D.2010209@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235CB5D.2010209@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/05 12:35 -0500, Wen Xiong wrote:
> Domen Puncer wrote:
> 
> >Just some nitpicking...
> >
> > 
> >
> Hi Domen, all,
> 
> Thanks for your comments. I  did some minor changes for patch1 based on 
> Domen's comment.
> 

And i missed, what is probably a bug:


> +module_param(jsm_debug, int, 0);
> +module_param(jsm_rawreadok, int, 1);

Last parameter is sysfs file mode, or 0 if no file is to be created.


	Domen
