Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267201AbSKPBly>; Fri, 15 Nov 2002 20:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbSKPBly>; Fri, 15 Nov 2002 20:41:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14600 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267201AbSKPBlx>;
	Fri, 15 Nov 2002 20:41:53 -0500
Message-ID: <3DD5A3E2.3020304@pobox.com>
Date: Fri, 15 Nov 2002 20:48:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jburks@wavicle.org
CC: linux-kernel@vger.kernel.org, sdroemen@cox.net
Subject: Re: 2.5.47 bk latest pull
References: <20021116012156Z267181-32597+23019@vger.kernel.org>
In-Reply-To: <20021116012156Z267181-32597+23019@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Burks wrote:

> I've had this same problem using 2.5.47bk4 from kernel.org.
>
> I also noticed that make modules_install no longer runs depmod, so my
> module dependencies didn't get set up until I ran depmod manually 
> which then
> exposed the QM_MODULES problem.


you need the new modutils:

http://www.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.7.tar.gz

