Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSGPPT7>; Tue, 16 Jul 2002 11:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317863AbSGPPT6>; Tue, 16 Jul 2002 11:19:58 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:14599 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S317862AbSGPPT4>; Tue, 16 Jul 2002 11:19:56 -0400
X-Server-Uuid: 95b8ca9b-fe4b-44f7-8977-a6cb2d3025ff
Message-ID: <03781128C7B74B4DBC27C55859C9D73809840661@es06snlnt>
From: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Using large amounts of memory in the kernel
Date: Tue, 16 Jul 2002 09:22:51 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Filter-Version: 1.8 (sass2426)
X-WSS-ID: 112AE62A242055-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a hash table of packet manipulation information
I need to use inside of a module in my kernel. The problem
is that this hash table is around 2MB. I'm trying to figure
out ways to shrink this table, but I'm coming up short on
ideas. What would be a good way to be able to allocate enough
memory to store all of this information?

Jeff Shipman - CCD
Sandia National Laboratories
(505) 844-1158 / MS-1372

