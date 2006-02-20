Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWBTDeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWBTDeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 22:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWBTDd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 22:33:59 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:5041 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932599AbWBTDd7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 22:33:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YCDWlJmXXCRuL22hlT0wfHAXtsLOeZItSULuCJcU0wl905Wsiq3TtYS9aNUG0tALRHrX8BuGYC5aOFxKqNcZnCD85crzclJ5+xUXHMlR6N+FBF9VsqNHNyopDeHPdVyVUwPGi+0+HWxRghuZmMiw/1Fi5TGdxknZRb0EO26/X1o=
Message-ID: <93564eb70602191933x2a20ce0m@mail.gmail.com>
Date: Mon, 20 Feb 2006 12:33:55 +0900
From: "Samuel Masham" <samuel.masham@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] make INPUT a bool
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Dmitry Torokhov" <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060217163802.GI4422@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060214152218.GI10701@stusta.de>
	 <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr>
	 <20060214182238.GB3513@stusta.de>
	 <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr>
	 <20060217163802.GI4422@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> And I've already given numbers why CONFIG_EMBEDDED=y and
> CONFIG_MODULES=y at the same time is insane.

>From your numbers this sounds true ... but actually you might want the
modules to delay the init of the various hardware bits...

Sometime boot-time is king and you just try and get back as much of
the size costs as it takes...

I think for EMBEDDED and MODULES is actually a very common case ... if
somewhat odd.

Samuel
