Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264623AbSIQVam>; Tue, 17 Sep 2002 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSIQVam>; Tue, 17 Sep 2002 17:30:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35203 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264623AbSIQVam>;
	Tue, 17 Sep 2002 17:30:42 -0400
Date: Tue, 17 Sep 2002 14:26:35 -0700 (PDT)
Message-Id: <20020917.142635.114214508.davem@redhat.com>
To: akpm@digeo.com
Cc: manfred@colorfullife.com, linux-netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D879F59.6BDF9443@digeo.com>
References: <3D87881F.4070808@colorfullife.com>
	<20020917.135939.52477700.davem@redhat.com>
	<3D879F59.6BDF9443@digeo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Tue, 17 Sep 2002 14:32:09 -0700

   There is a similar background loadtester at
   http://www.zip.com.au/~akpm/linux/#zc .
   
   It's fairly fancy - I wrote it for measuring networking
   efficiency.  It doesn't seem to have any PCisms....
   
Thanks I'll check it out, but meanwhile I hacked up sparc
specific assembler for manfred's code :-)

   (I measured similar regression using an ancient NAPIfied
   3c59x a long time ago).
   
Well, it is due to the same problems manfred saw initially,
namely just a crappy or buggy NAPI driver implementation. :-)
