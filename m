Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263739AbTCVTNM>; Sat, 22 Mar 2003 14:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbTCVTNM>; Sat, 22 Mar 2003 14:13:12 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21659
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263739AbTCVTNL>; Sat, 22 Mar 2003 14:13:11 -0500
Subject: Re: IDE todo list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas Wourms <nwourms@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7CA555.9050203@myrealbox.com>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
	 <20030322172453.GB9889@vana.vc.cvut.cz>
	 <1048360040.9221.23.camel@irongate.swansea.linux.org.uk>
	 <3E7CA555.9050203@myrealbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048365383.9221.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 20:36:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 18:03, Nicholas Wourms wrote:
> The AMD Opus ide driver is also displaying symptoms of the 
> same problem I had in 2.4.21-ac with UDMA100.  To refresh, 
> it was detecting 80w as 40w and 40w as 80w [reverse logic]. 
>   I am going to try the same fix which was posted for my 
> 2.4.21-ac problem.  I'll let you know if it worked...

The cable detect stuff for AMD is fixed in the current driver
I believe. Its not however full resynched into 2.5.6x yet. I
need to finish merging the proc fixes into 2.4 before I do that

