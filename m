Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVCHRjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVCHRjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVCHRjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:39:54 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:60569 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261442AbVCHRjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:39:48 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: chaosite@gmail.com
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Tue, 8 Mar 2005 09:39:08 -0800
User-Agent: KMail/1.7.2
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Januszewski <spock@gentoo.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <20050308021706.GH26249@spock.one.pl> <200503080418.08804.arnd@arndb.de> <422D3155.9000102@gmail.com>
In-Reply-To: <422D3155.9000102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503080939.09306.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 7, 2005 9:00 pm, Matan Peled wrote:
> Arnd Bergmann wrote:
> > Nothing about the init command seems really necessary. Why not just do
> > that stuff from an /sbin/init script?
>
> I'm not a kernel hacker by any definition, but I'm pretty sure its
> neccasery because we want it to be done before /sbin/init is ran, AKA hide
> the kernel messages :)

You can already hide the kernel messages by booting with the 'quiet' option.  
It works pretty well and it seems like this stuff should be in userspace 
anyway (console support in general that is).

Jesse
