Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbTIYTvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTIYTvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:51:55 -0400
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:41645 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S261514AbTIYTvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:51:53 -0400
Message-ID: <3F734762.4020600@davehollis.com>
Date: Thu, 25 Sep 2003 15:52:02 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bradley Chapman <kakadu_croc@yahoo.com>
CC: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test broke RPM 4.2 on Red Hat 9 in a VERY weird way
References: <20030925171025.98557.qmail@web40911.mail.yahoo.com>
In-Reply-To: <20030925171025.98557.qmail@web40911.mail.yahoo.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman wrote:

>
>I tried it the first way and I got the same error. I've already upgraded my glibc;
>do I need to reboot to 2.4.22-ac2 and upgrade some other system component, like
>ld.so?
>
>Brad
>
>
>=====
>Brad Chapman
>
>
>  
>
A few ways to solve this:
What I did before upgrading RPM was:
export LD_ASSUME_KERNEL=2.2.5
rpm -Uvh blah.rpm

If you upgrade to rpm that is in RedHat Rawhide (current 4.2.1-0.30), 
this problem goes away.  You may need to upgrade your glibc as well, I'm 
currently at 2.3.2-91 from Rawhide.

