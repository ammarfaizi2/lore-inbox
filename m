Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTDTODH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 10:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTDTODG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 10:03:06 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:19159 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S263582AbTDTODF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 10:03:05 -0400
Message-ID: <3EA2A9D7.6020109@cox.net>
Date: Sun, 20 Apr 2003 07:08:23 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 oops booting with initrd
References: <3EA22FDD.6010109@cox.net>
In-Reply-To: <3EA22FDD.6010109@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:

> Very small and simple kernel configuration (includes devfs, which is 
> where this problem came from), using Etherboot to load it along with a 
> small (768K) initrd.
> 

After sleeping on it I realized this problem may have been caused by 
neglecting to compile ext2 into the kernel (the initrd is an ext2 
image). Unfortunately, that is not the solution, the oops still occurs.

