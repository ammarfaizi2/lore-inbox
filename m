Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUCJU5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUCJU5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:57:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:424 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262820AbUCJU5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:57:09 -0500
Message-ID: <404F8118.1060203@pobox.com>
Date: Wed, 10 Mar 2004 15:56:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH] 2.4.x Linux Medley RAID Version 7
References: <200403101707.38595.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.40.0403101917170.2582-100000@jehova.dsm.dk> <c2nv0b$j5$1@news.cistron.nl>
In-Reply-To: <c2nv0b$j5$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> MD already has support for more than one type of superblock. I think
> if you just add medley (or intel, or ..) support to MD you're all set.

Indeed.  Further, we have the new vendor-neutral RAID metadata format, 
"DDF", looming on the very near horizon.

I want to avoid having NN duplicated RAID0/1/5 engines, like ataraid in 
2.4 was threatening to be.

	Jeff



