Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753512AbWKCT6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbWKCT6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbWKCT6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:58:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753512AbWKCT6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:58:37 -0500
Date: Fri, 3 Nov 2006 11:58:33 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "roland" <devzero@web.de>
Cc: <yoshfuji@linux-ipv6.org>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: unregister_netdevice: waiting for eth0 to become free
Message-ID: <20061103115833.7ecf1af2@freekitty>
In-Reply-To: <01d001c6ff81$b4bb5dc0$962e8d52@aldipc>
References: <01a501c6ff74$6fc52c80$962e8d52@aldipc>
	<20061104.034726.27678443.yoshfuji@linux-ipv6.org>
	<01d001c6ff81$b4bb5dc0$962e8d52@aldipc>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 20:53:09 +0100
"roland" <devzero@web.de> wrote:

> > The ipv6 module cannot be unloaded once it has been
> > loaded.
> 
> sorry,  i thought i could rmmod evey module which was insmod/modprobe'd 
> before and i didn`t know that there are exceptions
> 
> > I'm not sure what is happened with vmware.
> 
> i think this is not completely related to vmware - but maybe this is being 
> triggered more often by vmware ?
> http://www.google.de/search?hl=de&q=%22unregister_netdevice%3A+waiting+for+eth0+to+become+free
> 
> it`s really strange, but after taking a look,  vmware seems to recommend 
> disabling ipv6 for _every_ linux based guest OS in general:
> http://pubs.vmware.com/guestnotes/wwhelp/wwhimpl/common/html/wwhelp.htm?context=gos_ww5_output&file=choose_install_guest_os.html
> 
> since there are already running millions of  linux based VMs in this world, 
> i think this isn`t very good "promotion" for ipv6, if vmware recommending 
> disabling it.
> ok, there are not that much people already needing ipv6 NOW, but the later 
> they are running it and the later outstanding bugs being fixed, the harder 
> it will be to convert from ipv4 to ipv6....
> 
> roland
> 
> 

Vmware has there own pseudo ethernet device and unless you have the source for it.
It would be hard to tell if it correctly manages itself.


-- 
Stephen Hemminger <shemminger@osdl.org>
