Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVLGOjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVLGOjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVLGOjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:39:17 -0500
Received: from host94-205.pool8022.interbusiness.it ([80.22.205.94]:28592 "EHLO
	waobagger.intranet.nucleus.it") by vger.kernel.org with ESMTP
	id S1751063AbVLGOjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:39:17 -0500
From: Massimiliano Hofer <max@bbs.cc.uniud.it>
Organization: Nucleus snc
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Wed, 7 Dec 2005 15:38:54 +0100
User-Agent: KMail/1.9
References: <20051203135608.GJ31395@stusta.de> <20051205151753.GB4179@unthought.net> <20051206174424.GC3084@kroah.com>
In-Reply-To: <20051206174424.GC3084@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071538.55967.max@bbs.cc.uniud.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 6 December 2005 6:44 pm, Greg KH wrote:

> > Now what? Do I as a user upgrade my production environment to the latest
> > and greatest kernel experiment, hope that the problems can be fixed
> > quickly, and hope that I don't lose too much data in the process?
>
> No, if you rely on a production environment for your stuff, stick with a
> disto kernel which has been tested and is backed up by a company that
> will maintain it over time.

If the purpose of not having a 2.7 branch or longer RCs is to have people test 
the latest vanilla, you can't simultaneously send users away.

I maintain a number of servers and don't like to depend on a distro for the 
kernel. I do my tests before deployment and can live with some problems in a 
specific release (noone is perfect), but I'd like to have a plan B without 
creating my own branch.

Having security patches in a 2.6.(x-1).y would allow me to test the latest 
vanilla AND have stable production servers without the rush that usually 
accompanies a new release followed by a vulnerability.

-- 
Bye,
   Massimiliano Hofer
