Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261538AbTCGLmn>; Fri, 7 Mar 2003 06:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbTCGLmn>; Fri, 7 Mar 2003 06:42:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40361
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261538AbTCGLmj>; Fri, 7 Mar 2003 06:42:39 -0500
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "rain.wang" <rain.wang@mic.com.tw>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E683663.EBD184A4@mic.com.tw>
References: <3E5CEF17.4C014A4C@mic.com.tw>
	 <1046288652.9837.18.camel@irongate.swansea.linux.org.uk>
	 <3E5EEDF9.5906D73E@mic.com.tw>  <3E64A8A5.4EBB5FB3@mic.com.tw>
	 <1046791639.10857.12.camel@irongate.swansea.linux.org.uk>
	 <3E683663.EBD184A4@mic.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047041925.20794.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 12:58:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 06:04, rain.wang wrote:
> > Once I understand what the problems all are yes. The BUG() is good, it
> > confirms that what we are both seeing is the same thing - the reset is
> > managing to issue two commands to the controller at the same time.
> 
> Hi,
>     thank you, Alan. I tested pre5-ac2 patch and that seems all ok.

Thanks for the confirmation it is fixed

