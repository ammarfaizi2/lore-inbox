Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUB0Shq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUB0SgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:36:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262936AbUB0SfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:35:11 -0500
Message-ID: <403F8DD1.9030001@pobox.com>
Date: Fri, 27 Feb 2004 13:34:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Creswell <dan@dcrdev.demon.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hard locks under high interrupt load?
References: <403F2237.6080505@dcrdev.demon.co.uk>
In-Reply-To: <403F2237.6080505@dcrdev.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Creswell wrote:
> I'm having zero success in getting 2.6.3 stable under interrupt load.  I 
> can kill my machine in a variety of fashions all of which appear, to my 
> naive eye, related to interrupt load:


There is a lockup problem in 2.6.3's e1000 that's solved in 2.6.3-bk 
snapshot.

	Jeff



