Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWCFObe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWCFObe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 09:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCFObe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 09:31:34 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:19497 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750958AbWCFObd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 09:31:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UN1Nze8UZbP5+eRAHS/rgBJZoNmmfriJH6f2yVxozUmZ7HzIqCJCZTZCchsO3D2qoVxg1hgdXiF8kGgFpxfomvkNNqD0wN/pLyXwdmtrm7oXYYgx8qqfI+n42GHdMAg1keEQ4pUwkm32Kk0m4qJwfcXT5YYrDytvycbkTq8fADk=
Message-ID: <c43b2e150603060631h494b920g84cf357f376d64bb@mail.gmail.com>
Date: Mon, 6 Mar 2006 15:31:32 +0100
From: wixor <wixorpeek@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: using usblp with ppdev?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060303170752.GA5260@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com>
	 <20060302165557.GA31247@kroah.com>
	 <c43b2e150603030512l141c101va11300bcfbda4f60@mail.gmail.com>
	 <20060303170752.GA5260@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What is the output of /proc/bus/usb/devices with your device plugged in?
>
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12 MaxCh=0
D: Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P: Vendor=067b ProdID=2305 Rev= 2.02
S: Manufacturer=Proliftic Technology Inc.
D: Product=IEEE-1284 Controller
C:* #Ifs=1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=07(print) Sub=01 Prot=01 Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I: If#=0 Alt=1 #EPs=2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MaxPS=64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MaxPS=64 Ivl=0ms
I: If#=0 Alt=2 #EPs=3 Cls=ff(vend.) Sub=00 Prot=ff Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MaxPS=64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MaxPS=64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MaxPS=4 Ivl=1ms
