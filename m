Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVFJXrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVFJXrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVFJXrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:47:41 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:56023 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261477AbVFJXqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:46:25 -0400
Date: Sat, 11 Jun 2005 01:41:47 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Hutchings <info@a-wing.co.uk>
Cc: linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com, pascal.chapperon@wanadoo.fr
Subject: Re: sis190
Message-ID: <20050610234147.GA5062@electric-eye.fr.zoreil.com>
References: <42A621BC.7040607@a-wing.co.uk> <20050607225755.GB30023@electric-eye.fr.zoreil.com> <42A62BD0.7090709@a-wing.co.uk> <20050608225157.GA16107@electric-eye.fr.zoreil.com> <42A82FE3.3080603@a-wing.co.uk> <20050609211843.GA5630@electric-eye.fr.zoreil.com> <42A99BCD.8000901@a-wing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A99BCD.8000901@a-wing.co.uk>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Hutchings <info@a-wing.co.uk> :
[...]
> Something went wrong on build.  Getting 'syntax error before '}' token' 
> on every line there is _msleep(1);

I have checked it again and the patch applies and compiles correctly
against 2.6.12-rc6. So does the updated patch of the day:

http://www.fr.zoreil.com/people/francois/misc/20050611-2.6.12-rc-sis190-test.patch

No need to use SIS190_NO_DELAY so far. The media negotiation process has
been changed. It is now allowed to take longer to complete (it should help).

dmesg and ifconfig output will be welcome.

--
Ueimor
