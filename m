Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTAPKDj>; Thu, 16 Jan 2003 05:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTAPKDi>; Thu, 16 Jan 2003 05:03:38 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:5512 "EHLO
	columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S265987AbTAPKDi>; Thu, 16 Jan 2003 05:03:38 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: linux-kernel@vger.kernel.org
cc: raul@pleyades.net
Message-ID: <80256CB0.00381BB6.00@notesmta.eur.3com.com>
Date: Thu, 16 Jan 2003 10:12:23 +0000
Subject: Re: Changing argv[0] under Linux.
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Any suggestion on how to get the binary name from the core image?

How about:

exec("/proc/self/exe", ...)

I found something like this handy when writing an self extracting compressed
executable a while ago.

     Jon


