Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTEHP3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTEHP3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:29:55 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:9704 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S261706AbTEHP3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:29:54 -0400
Message-ID: <3EBA7AE2.4000004@cox.net>
Date: Thu, 08 May 2003 08:42:26 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Boyce <gboyce@rakis.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Not enough ptys in 2.5.69-mm2
References: <Pine.LNX.4.42.0305081126040.15163-300000@egg>
In-Reply-To: <Pine.LNX.4.42.0305081126040.15163-300000@egg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Boyce wrote:


> gboyce@cthulhu gboyce $ xterm
> xterm: Error 32, errno 2: No such file or directory
> Reason: get_pty: not enough ptys
> 

Have you mounted devpts on /dev/pts? If not, that's now mandatory after 
some devfs changes that went in during 2.5.68/2.5.69 timefreame.

