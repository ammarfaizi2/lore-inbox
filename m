Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTCDXek>; Tue, 4 Mar 2003 18:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbTCDXek>; Tue, 4 Mar 2003 18:34:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:11690 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265578AbTCDXeh>;
	Tue, 4 Mar 2003 18:34:37 -0500
Date: Tue, 4 Mar 2003 15:41:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel bloat 2.4 vs. 2.5
Message-Id: <20030304154105.7a2db7fa.akpm@digeo.com>
In-Reply-To: <1046817738.4754.33.camel@sonja>
References: <1046817738.4754.33.camel@sonja>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2003 23:44:59.0716 (UTC) FILETIME=[11951040:01C2E2A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger <degger@fhm.edu> wrote:
>
> Hija,
> 
> I've seen surprisingly few messages about the dramatic size increase
> between a simple 2.4 and a 2.5 kernel image. 
> 
> I just decided to check back with the 2.5 series again after my last try
> with 2.5.53 (which wouldn't even boot) but had to dramatically cut down
> the kernel featurewise to keep it below 1MB because I can't boot it over
> tftp otherwise. 
> 
> 909824 Feb 14 20:02 vmlinuz-192.168.11.3-2.4.20
> 954880 Mar  4 17:01 vmlinuz-192.168.11.3-2.5.63

2.4 has magical size reduction tricks in it which were not brought into 2.5
because we expect that gcc will do it for us.

Please specify the compiler which was used, and use /usr/bin/size to report
image sizes.


