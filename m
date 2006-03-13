Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWCMIBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWCMIBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWCMIBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:01:10 -0500
Received: from main.gmane.org ([80.91.229.2]:54942 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932335AbWCMIBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:01:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lexington Luthor <lexington.luthor@gmail.com>
Subject: Re: Which kernel is the best for a small linux system?
Date: Mon, 13 Mar 2006 08:00:51 +0000
Message-ID: <dv38rn$430$1@sea.gmane.org>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bb-82-108-13-253.ukonline.co.uk
User-Agent: Thunderbird 1.5.0.2 (Windows/20060302)
In-Reply-To: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

j4K3xBl4sT3r wrote:
> Hello all,
> 
> I've been seeing many Linux versions, with many features, some of them
> just for the newest branches (2.4.x and 2.6.x), I would like to know
> for which kind of system each kernel is recommended.

Hi,

I am not a kernel developer, so this is not an official recommendation, 
but exactly what kind of "small" system do you mean?

I build and maintain a Linux distribution geared for memory-constrained 
x86 systems, as old as 386s with 4MB of RAM, and the 2.6 kernel fairs 
very well there. I only do so as a hobby not officially supported, so I 
haven't tested the distribution with a very wide range of workloads, but 
for bootstrapping itself from sources and for general home LAN routing 
work, its great.

You might want to look into patch sets like the 2.6-tiny patches, which 
greatly reduce the memory footprint of the kernel: 
http://www.selenic.com/linux-tiny/

Also, you might want to look into the uclibc or dietlibc libraries, 
which are a much smaller and less memory hungry than glibc (which has 
become a memory pig in recent years).

Regards,
LL

