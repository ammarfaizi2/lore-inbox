Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266576AbUAWPJK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbUAWPJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:09:09 -0500
Received: from gw-nl4.philips.com ([212.153.190.6]:61056 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP id S266576AbUAWPJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:09:02 -0500
Message-ID: <401139B2.2090301@basmevissen.nl>
Date: Fri, 23 Jan 2004 16:11:46 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make in 2.6.x
References: <20040123145048.B1082@beton.cybernet.src>
In-Reply-To: <20040123145048.B1082@beton.cybernet.src>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavý wrote:
> Hello
> 
> Is it correct to issue "make bzImage modules modules_install"
> or do I have to do make bzImage; make modules modules_install?

# make all modules_install install

Builds image and modules and installs them both. At least on Redhat, 
also an initial ram disk is created and grub is adapted.

> Is there any documentation where I can read answer to this question?
> 

# make help

and read the top-level Makefile itself. It is a quite readable file format.

Regards,

Bas.

