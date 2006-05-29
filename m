Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWE2Vam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWE2Vam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWE2V34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:29:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:62404 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751376AbWE2V3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:29:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=THByIp64KgGVDgYo4JuW29aecrlerRXNS9PSZ65BZboG4cHBGUv8BgmArs7/Fw5nVoeD1FU2YC9iJ5NHEOjocV8OgmlhX4bwVdqeyUgX7v/hRzZRJoTDwzLiP42ZB/4XPVAlUOqrD9dZW/alx524/ocTcJq4Xx31YTXNNMPtnsE=
Message-ID: <9a8748490605291429h32f67b53k757d6e4a0cec7675@mail.gmail.com>
Date: Mon, 29 May 2006 23:29:53 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "=?ISO-8859-1?Q?Jo=E3o_Luis_Meloni_Assirati?=" 
	<assirati@nonada.if.usp.br>
Subject: Re: /sys/class/net/eth?/carrier and uevents
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605291807.42725.assirati@nonada.if.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200605291807.42725.assirati@nonada.if.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/06, João Luis Meloni Assirati <assirati@nonada.if.usp.br> wrote:
>
> Hello,
>
Hi,

> I would like to have my network interfaces configured when plugged on the
> network cable. I know there are some daemons that do this for me (laptop-net,
> ifplugd, whereami), but it would be nice if a simple udev rule take care of
> this to me. However, as I can see with kernel 2.6.16 and udevmonitor (udev
> version 0.091), nonetheless /sys/class/net/eth?/carrier changes when I plug
> the network cable, no uevent is generated. Could this be changed so udev get
> triggered when network cables get plugged? As I am no kernel developper, this
> is only a suggestion, hoping that it would be a simple and pertinent job for
> those ho know the subject.
>

I added the 'carrier' attribute initially but never considered udev at
the time. But I can certainly see how it could be useful.
I'll take a look at adding a hotplug event when I get some spare time
(probably some time next week) - or perhaps someone else will beat me
to it :)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
