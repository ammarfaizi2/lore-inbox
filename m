Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSJTOn2>; Sun, 20 Oct 2002 10:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbSJTOn2>; Sun, 20 Oct 2002 10:43:28 -0400
Received: from cs.columbia.edu ([128.59.16.20]:59294 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S262806AbSJTOn2>;
	Sun, 20 Oct 2002 10:43:28 -0400
Subject: Re: can chroot be made safe for non-root?
From: Shaya Potter <spotter@cs.columbia.edu>
To: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E183DV6-0004ha-00@sites.inka.de>
References: <E183DV6-0004ha-00@sites.inka.de>
Content-Type: text/plain
Organization: 
Message-Id: <1035125354.2172.5.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2 (Preview Release)
Date: 20 Oct 2002 10:49:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-20 at 06:40, Bernd Eckenfels wrote:
> In article <200210191942.g9JJg2U26376@marc2.theaimsgroup.com> you wrote:
> > IIRC, FreeBSD allow a chroot'ed process to chroot again if and only if 
> > the  
> > new root is a subdirectory of the initial chroot.  This allows things 
> > like  
> > traditional, chrooting anonymous FTP to be run under an initial chroot.    
> 
> well, you can only changeroot in a subdir anyway, so this is not the point
> that freebsd is allowing a chroot in a chroot. As far as I know they simply
> solved the break out issue. 

didn't see the mail this is in response to, but are you talking about
FreeBSD's jail() syscall? or are you talking about chroot() actually
being able to nest?

