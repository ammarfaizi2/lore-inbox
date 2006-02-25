Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWBYO5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWBYO5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWBYO5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:57:16 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:50476 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030240AbWBYO5P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:57:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TWXkwwxKFjikmcYP4WKYQOv+scrk4BRoZwkIwQqRKlfRkPQlBiYMy4g/mqz4/eMKfDGIVnCvGNHrnRvdUHwKs/sPoAk2bjbKWp1TKXv/HyrMYv7Lje+3AzBM/BXSBXoZOz4Z4OicgrgcUL/DWXACo1DXU1Dibi4GTdivdI9g/eQ=
Message-ID: <9a8748490602250657y1969f64ct85d3a4042b1ebf04@mail.gmail.com>
Date: Sat, 25 Feb 2006 15:57:14 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: [2.6 patch] make INPUT a bool
Cc: "Adrian Bunk" <bunk@stusta.de>,
       "Geert Uytterhoeven" <geert@linux-m68k.org>,
       "Samuel Masham" <samuel.masham@gmail.com>,
       "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602251521300.31692@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060214152218.GI10701@stusta.de>
	 <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr>
	 <20060217163802.GI4422@stusta.de>
	 <93564eb70602191933x2a20ce0m@mail.gmail.com>
	 <20060220132832.GF4971@stusta.de>
	 <20060222013410.GH20204@MAIL.13thfloor.at>
	 <20060222023121.GB4661@stusta.de>
	 <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be>
	 <20060225124606.GI3674@stusta.de>
	 <Pine.LNX.4.61.0602251521300.31692@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >
> >My 50 MB number was much too high (I didn't want to think where exactly
> >to set the borderline).
> >
> >My point is that if you are in an environment that is that space limited
> >that you want to see options that allow e.g. not building futexes,
> >module support with an impact of approx. 10% on code size would be one
> >of the first things you should disable.
> >
>
> You said that INPUT was not a driver, right. But without it, a keyboard
> won't work, will it?
>
No, it won't, so if you want to use a keyboard you build INPUT into the kernel.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
