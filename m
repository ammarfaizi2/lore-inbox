Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVCDSLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVCDSLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbVCDSLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:11:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34243 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262949AbVCDSKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:10:53 -0500
Date: Fri, 4 Mar 2005 13:10:50 -0500
From: Dave Jones <davej@redhat.com>
To: Richard Fuchs <richard.fuchs@inode.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
Message-ID: <20050304181050.GB4484@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Richard Fuchs <richard.fuchs@inode.info>,
	linux-kernel@vger.kernel.org
References: <42283093.7040405@inode.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42283093.7040405@inode.info>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:55:31AM +0100, Richard Fuchs wrote:
 > hello all!
 > 
 > the memory allocation debugger gives me the following messages under a
 > vanilla 2.6.10 and 2.6.11 kernel when doing
 > 
 > 1) hdparm -d0 on my hard disk
 > 2) tar c / > /dev/null
 > 3) sending lots of network traffic to the machine (e.g. close to 100
 > mbit/s udp packets)

Which network drivers are in use on the box that gets the corruption ?

		Dave

