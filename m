Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVKFBk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVKFBk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 20:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVKFBk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 20:40:26 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:44736 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932276AbVKFBkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 20:40:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=YqA8soLt1ZeTALkPTeRVpkn2C+fzHLsHH0sDaRFkAk+GjuMhwdEinJKtIOmhUnrILyBIJin1g/cTpbplapd+5TKwuYUo537yobZ+cx/iWGE2svMVBkO3Buhq/M0Ff8arast9mQnSRo+VfCF6SOVp9VxT5dFrVlbEKpSOXtpL448=
Message-ID: <436D5EFD.9000800@gmail.com>
Date: Sun, 06 Nov 2005 09:40:13 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mlang@debian.org
Subject: Re: [PATCH] Set the vga cursor even when hidden
References: <20051105211949.GM7383@bouh.residence.ens-lyon.fr> <436D5047.4080006@gmail.com> <Pine.LNX.4.64.0511051642580.3316@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511051642580.3316@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 6 Nov 2005, Antonino A. Daplas wrote:
>> Note that this method will produce a split block cursor with EGA, which is
>> still supported by vgacon, but possibly not used anymore.  Why not use
>> this method (scanline_end < scanline_start) for VGA, and the default method
>> (moving the cursor out of the screen) for the rest?
> 
> I do believe that we can ignore EGA controllers these days.
> 
> Or at least accept the fact that anybody who owns an EGA system isn't 
> actually likely to care about what his screen looks like.
> 
> The EGA support was pretty much a joke even when Linux started ;)
> 

Okay, it was a half-hearted comment in the first place :-)

Tony
