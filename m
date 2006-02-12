Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWBLVvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWBLVvg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWBLVvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:51:35 -0500
Received: from terminus.zytor.com ([192.83.249.54]:42975 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751452AbWBLVvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:51:35 -0500
Message-ID: <43EFADD9.7010909@zytor.com>
Date: Sun, 12 Feb 2006 13:51:21 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.2.0
References: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> The latest feature release GIT 1.2.0 is available at the
> usual places:
> 
> 	http://www.kernel.org/pub/software/scm/git/
> 
> 	git-1.2.0.tar.{gz,bz2}			(tarball)
> 	RPMS/$arch/git-*-1.2.0-1.$arch.rpm	(RPM)
> 
> Right now binary RPM is available only for x86_64, because I do
> not have an access to RPM capable i386 box.
> 

You can build the i386 binary rpms on hera as such:

rpmbuild --rebuild --target i386 git-1.2.0-1.src.rpm

I had to install openssl-devel from the i386 distribution, which for 
some reason wasn't part of the x86-64 distribution, but that's now taken 
care of.

	-hpa
