Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWEZOaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWEZOaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWEZOaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:30:10 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:4587 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1750790AbWEZOaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:30:08 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1148596163.31038.30.camel@mindpipe>
References: <e55715+usls@eGroups.com>  <1148596163.31038.30.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:29:54 +0200
Message-Id: <1148653797.3579.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 18:29 -0400, Lee Revell wrote:
> On Thu, 2006-05-25 at 21:19 +0000, devmazumdar wrote:
> > How does one check the existence of the kernel source RPM (or deb) on
> > every single distribution?.
> > 
> > We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> > SuSE, Mandrake and CentOS - how about other RPM based distros? How
> > about debian based distros?. There doesn't seem to be a a single
> > conherent naming scheme.  
> 
> I'd really like to see a distro-agnostic way to retrieve the kernel
> configuration.  /proc/config.gz has existed for soem time but many
> distros inexplicably don't enable it.

/boot/config-`uname -r`


