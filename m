Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVCROIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVCROIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 09:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCROIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 09:08:10 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:15003 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261607AbVCROIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 09:08:09 -0500
Date: Fri, 18 Mar 2005 15:09:41 +0100
From: Juergen Quade <quade@hsnr.de>
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel space sockets
Message-ID: <20050318140941.GA31622@hsnr.de>
References: <423ADD5B.5060708@euroweb.net.mt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <423ADD5B.5060708@euroweb.net.mt>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 02:53:31PM +0100, Josef E. Galea wrote:
> Hi,
> 
> I'm trying to implement a UDP server in a kernel module. So far I have 
> created the struct socket using sock_create_kern(), and used 
> sock->ops->bind() on it. Now how do I send UDP datagrams? I looked at 
> some code and found the function sock->ops->sendmsg() but I can't figure 
> out where to put the destination address. I would appreciate it if 
> someone could point me to some tutorial or sample code.

Maybe the sample code on this (german) site helps:

http://ezs.kr.hsnr.de/TreiberBuch/Artikel/index.html

Look at "Folge" 16.

          Juergen.
