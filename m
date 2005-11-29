Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVK2AU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVK2AU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVK2AU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:20:59 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:60489 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932285AbVK2AU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:20:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Xziv61aAVzjHxUFYJXmTRfHTP0YGEdxgdQR5g0Ks4y2Sl/PboCDW0mEewbFE2xW3Q3dV5qs8Xdv3D3v7wFFzRAMsvE3HTXKu4AUpAftH+WcKoeNYd2Rvr4vQZii2h/YtcRZhOrsG8sZtqsnaah/AsT8O8ZMlgeYhNVfz6aMerCA=
Message-ID: <438B9EC1.2090107@gmail.com>
Date: Tue, 29 Nov 2005 08:20:17 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: nvidia fb flicker
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu> <20051128103554.GA7071@stiffy.osknowledge.org> <1drow6iat7zy8.2rt89nl7eodg.dlg@40tude.net>
In-Reply-To: <1drow6iat7zy8.2rt89nl7eodg.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Mon, 28 Nov 2005 11:35:54 +0100, Marc Koschewski wrote:
> 
>> * Calin A. Culianu <calin@ajvar.org> [2005-11-26 00:02:46 -0500]:
>>
>>> [12 quoted lines suppressed]
>> Hi all,
>>
>> yesterday I compiled a 2.6.15-rc2 on one of my Inspirons (NVIDIA GeForce2 Go)
>> with nvidiafb. I just changed the fb to some 1600x1200 mode and thus seems to
>> work (the source states GeForce2 Go is supported and known). However, the
>> letters seems to 'flicker' in some way. Uhm, it's not really flickering, it's
>> more like the sinle dots a letter is made of seem to randomly turn on an off. I
>> one takes a closer look it seems like the whole screen is 'fluent' or something.
>> Does anybody know how to handle that? I didn't specify a video mode, but
>> 'video=vesafb:mtrr:3'. 
> 
> Let me guess ... you have a Dell Inspiron 8200 or some such? You must
> compile nvidiafb without support for DDC.
> 
> (Antonio, any news on disabling DDC from the command line? like a
> noddc option or some such?)

Yes, I always forget :-).  Let me see if we can have something that is nicer
(Linus' patch looks good so maybe you can help verify that). See the other
thread.

Tony
 
PS: It's best if you don't trim the cc list.

