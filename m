Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSGDWDR>; Thu, 4 Jul 2002 18:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSGDWDQ>; Thu, 4 Jul 2002 18:03:16 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:65111 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314529AbSGDWDP>; Thu, 4 Jul 2002 18:03:15 -0400
Date: Thu, 4 Jul 2002 21:45:21 +0100
From: Stephen Tweedie <sct@redhat.com>
To: Naseer Bhatti <naseer@digitallinx.com>
Cc: security@proftpd.org, security@apache.org, linux-kernel@vger.kernel.org,
       sct@redhat.com, akpm@zip.com.au, adilger@turbolinux.com,
       ext3-users@redhat.com
Subject: Re: your mail
Message-ID: <20020704214521.D27198@redhat.com>
References: <000d01c22361$62c9d6f0$0100a8c0@digital>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000d01c22361$62c9d6f0$0100a8c0@digital>; from naseer@digitallinx.com on Thu, Jul 04, 2002 at 06:47:11PM +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 04, 2002 at 06:47:11PM +0500, Naseer Bhatti <naseer@digitallinx.com> wrote:

> I got these errors in the log on a Production server. I am running ProFTPD 1.2.4 with RedHat 7.2 Kernel 2.4.7-10 not yet compiled myself and Apache 1.3.26. I got my server stop responding and after reboot I checked the logs and got a lots of kernel bugs. ProFTPD was also involved in that. httpd (Apache 1.3.26) also gave some stack output. Correct me if I am wrong. I have attached the file for detailed analysis. Please check it and let me know about the possible bug/solution.

The log shows no sign of any ext3 problem.  I can't see anything in it
which would justify trying to send a compressed log of nearly 400kB to
an ext3 general users mailing list.

For what it's worth, your dcache oopses are most often associated with
bad memory --- try memtest86 on that machine before you go any
further.

--Stephen
