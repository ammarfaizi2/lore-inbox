Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTDMXDE (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 19:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTDMXDE (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 19:03:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39863
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262656AbTDMXDD (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 19:03:03 -0400
Subject: Re: Benefits from computing physical IDE disk geometry?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304131407_MC3-1-3441-57C7@compuserve.com>
References: <200304131407_MC3-1-3441-57C7@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050272156.24559.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Apr 2003 23:15:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-13 at 19:03, Chuck Ebbert wrote:
>   OTOH you can come up with scenarios like, say, a DBMS doing 16K page
> aligned IO to raw devices where you might see big gains from making sure
> those 16K chunks didn't cross a physical cylinder boundary.

You couldn't even tell where such boundaries exist, or what the real
block size of the underlying media is. Cyliners are all different sizes.

