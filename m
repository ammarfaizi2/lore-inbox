Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTE2QqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTE2QqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:46:24 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:4524 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S262386AbTE2QqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:46:23 -0400
Date: Thu, 29 May 2003 09:59:40 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: Christoph Hellwig <hch@lst.de>,
       linux kernel <linux-kernel@vger.kernel.org>,
       GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Recent binutils releases and linux kernel 2.5.69+
Message-ID: <20030529095940.B31904@lucon.org>
References: <20030529074448.A29931@lucon.org> <20030529084948.A30796@lucon.org> <20030529160326.GB19751@lst.de> <200305291921.47154.kde@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305291921.47154.kde@myrealbox.com>; from kde@myrealbox.com on Thu, May 29, 2003 at 07:21:47PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 07:21:47PM +0300, ismail (cartman) donmez wrote:
> Hi,
> > On Thu, May 29, 2003 at 08:49:48AM -0700, H. J. Lu wrote:
> > > This is a kernel issue and should be fixed in kernel unless we want
> > > to do something in <sys/sysctl.h>.
> >
> > You should not include kernel headers from userspace.
> 
> Old story I know but I dont think binutils would use kernel headers if it 
> doesnt need it.
> 

<sys/sysctl.h> includes <linux/sysctl.h>. That is what I meant by "do
something in <sys/sysctl.h>."


H.J.
