Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVCZDw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVCZDw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVCZDwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:52:25 -0500
Received: from terminus.zytor.com ([209.128.68.124]:9117 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261934AbVCZDwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:52:23 -0500
Message-ID: <4244DC6A.3020304@zytor.com>
Date: Fri, 25 Mar 2005 19:52:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phil Lougher <phil.lougher@gmail.com>
CC: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       phillip@lougher.demon.co.uk
Subject: Re: Squashfs without ./..
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>	 <20050323174925.GA3272@zero>	 <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>	 <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>	 <d1v67l$4dv$1@terminus.zytor.com>	 <3e74c9409b6e383b7b398fe919418d54@mac.com> <cce9e37e0503251948527d322b@mail.gmail.com>
In-Reply-To: <cce9e37e0503251948527d322b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Lougher wrote:
> 
> Making readdir return '.' and '..' is trivially easy, as all the
> required information to fake '.' and '..' entries are present.
> 
> The lack of '.' and '..' entries hasn't caused any problems despite
> cramfs/squashfs being used for a large number of years.  I'm inclined
> to believe any application that _relies_ on seeing '.' and '..'
> returned by readdir is broken.  This situation is easily fixed within
> the application rather than forcing the filesystem to unnecessarily
> fake '.' and '..' entries which are never used.
> 

<sarcasm>

Yeah, let's fix every broken application on the planet instead of fixing 
it in one place...

</sarcasm>

	-hpa
