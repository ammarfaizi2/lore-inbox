Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWFSWSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWFSWSN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWFSWSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:18:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:54431 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964951AbWFSWSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:18:12 -0400
Message-ID: <4497228F.9030108@zytor.com>
Date: Mon, 19 Jun 2006 15:17:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Daniel Barkalow <barkalow@iabervon.org>
CC: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org, Joshua Hudson <joshudson@gmail.com>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
References: <20060618221343.GA20277@kroah.com>  <20060618230041.GG4744@bouh.residence.ens-lyon.fr>  <4495F5C3.1030203@zytor.com>  <bda6d13a0606181817q2ab4e5cev670ef5c537b63e6c@mail.gmail.com>  <4495FF59.2010100@zytor.com> <8e6f94720606182255u400964c2v1ea16221ffc5c94d@mail.gmail.com> <44964EDC.3030104@ums.usu.ru> <Pine.LNX.4.64.0606191801000.6713@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0606191801000.6713@iabervon.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Barkalow wrote:
> On Mon, 19 Jun 2006, Alexander E. Patrakov wrote:
> 
>> Will Dyson wrote:
>>> Providing the information about what devices a virtual driver will
>>> register when loaded seems like a good idea.
>> Why? This information is currently useless. What you want is that something
>> knows that you want this driver to be loaded.
> 
> The point is that you *don't* want those modules to be loaded. What you 
> want is for the kernel to know that those modules are available, and 
> therefore mention that drivers could be found for those devices, and 
> therefore udev would create the device nodes for them, even though the 
> kernel doesn't contain a module that drives them yet.
> 

The kernel doesn't need to know.  udev needs to know.

	-hpa
