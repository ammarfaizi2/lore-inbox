Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318173AbSIFKNY>; Fri, 6 Sep 2002 06:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSIFKNY>; Fri, 6 Sep 2002 06:13:24 -0400
Received: from 166.Red-80-36-134.pooles.rima-tde.net ([80.36.134.166]:64295
	"EHLO apocalipsis") by vger.kernel.org with ESMTP
	id <S318173AbSIFKNY>; Fri, 6 Sep 2002 06:13:24 -0400
Date: Fri, 6 Sep 2002 12:19:29 +0200
From: "Juan M. de la Torre" <jmtorre@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Little bug in O(1) scheduler patch (also in 2.4.19-ac4)
Message-ID: <20020906101929.GA265@apocalipsis>
References: <20020906083254.GA769@apocalipsis> <Pine.LNX.4.44.0209061106370.10843-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209061106370.10843-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I was wrong; the problem i was experimenting was due to a symbolic link
problem (i was compiling the module with other kernel headers). Since
the CRC of a versioned symbol is based on the function arguments i
thought that the different type of the argument (well, is the same type with 
different name) has something to do with the error i was getting.

 I apologize for wasting readers' time.

Regards,
Juanma

-- 
/jm

