Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWFTHRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWFTHRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFTHRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:17:16 -0400
Received: from relay2.uli.it ([62.212.1.5]:6295 "EHLO relay2.uli.it")
	by vger.kernel.org with ESMTP id S964925AbWFTHRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:17:16 -0400
From: Daniele Orlandi <daniele@orlandi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Passing references to kobjects between userland and kernel
Date: Tue, 20 Jun 2006 09:17:10 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200606141626.39273.daniele@orlandi.com> <200606200148.56117.daniele@orlandi.com> <20060619235355.GA26685@kroah.com>
In-Reply-To: <20060619235355.GA26685@kroah.com>
X-Message-Flag: Outlook puo' causare gravi danni alla salute. Pensaci.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606200917.13504.daniele@orlandi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 01:53, Greg KH wrote:
>
> Why do you feel that this is a requirement?  What exactly are you trying
> to do?

I have my channels interconnect graph, nicely exported to sysfs, and I just 
need an interface that an application could use to request connections 
between two nodes of this graph.

The result of the connection is a pipeline object, also exported to sysfs, 
that the application will use to do further work on the connection.

Currently I'm using an ioctl() but, given that ioctls seem to be a no-no for 
future projects, given that there is great effort in having new and better 
interfaces, I'm trying to figure out what is the best way to do what I need.

thanks,
Bye,

-- 
  Daniele Orlandi
