Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWJMQRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWJMQRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWJMQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:17:32 -0400
Received: from bay0-omc3-s41.bay0.hotmail.com ([65.54.246.241]:37845 "EHLO
	bay0-omc3-s41.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751639AbWJMQRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:17:31 -0400
Message-ID: <BAY20-F21743EEAB4B44BD437AE68D80A0@phx.gbl>
X-Originating-IP: [80.178.105.199]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <20061013155020.GA8204@redhat.com>
From: "Burman Yan" <yan_952@hotmail.com>
To: davej@redhat.com, jesper.juhl@gmail.com
Cc: linux-kernel@vger.kernel.org, pazke@donpac.ru
Subject: Re: [PATCH] HP mobile data protection system driver
Date: Fri, 13 Oct 2006 18:17:26 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 13 Oct 2006 16:17:30.0842 (UTC) FILETIME=[154443A0:01C6EEE3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Dave Jones <davej@redhat.com>
>To: Jesper Juhl <jesper.juhl@gmail.com>
>CC: Burman Yan <yan_952@hotmail.com>, linux-kernel@vger.kernel.org,        
>Andrey Panin <pazke@donpac.ru>
>Subject: Re: [PATCH] HP mobile data protection system driver
>Date: Fri, 13 Oct 2006 11:50:20 -0400

>Better yet, would be to use the same interface the hdaps driver uses
>so that userspace written for one accelerometer works with any hardware.
>Having to cope with a dozen different drivers who export in different
>places is just silly.
>

That would probably mean that there is a need for single interface. Making 
all accelerometers
export to /sys/devices/platform/hdaps sounds wrong to me. It should be a 
neutral place then.
There aren't that many accelerometers right now as far as I could tell by 
googling.
There are hdaps, amc (something for MAC I think) and now mdps ;)
Only amc and mdps are 3D - hdaps is 2D, and also amc and mdps in theory 
support
a free-fall interrupt instead of polling - I just couldn't get the interrupt 
part to work yet.

I did make the interface as close as I could to hdaps - seem my later post 
with a new patch.

Yan

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

