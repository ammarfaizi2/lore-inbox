Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbTFSBJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbTFSBJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:09:21 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:48857 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S265678AbTFSBJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:09:14 -0400
Message-ID: <3EF11080.5060507@cox.net>
Date: Wed, 18 Jun 2003 18:23:12 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: glibc compiling with kernel 2.5.70-bk17
References: <3EF10F3E.1090308@cern.ch>
In-Reply-To: <3EF10F3E.1090308@cern.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riccardo-Maria Bianchi wrote:
> 
> Good morning,
> 
> I'm trying to compiling several version of the glibc but always during 
> the "make" I obtain these errors:
> 

<snip>

> 
> Someone have an idea? :)
> 

Yes, the kernel headers are currently borked for compiling userspace C 
libraries. The fix is going to take either a large effort to get a 
sanitized set of userspace kernel headers created, or someone to be 
willing to accept patches that fix the problems with the existing 
headers even though userspace is not supposed to be using them.

