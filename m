Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVLNGiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVLNGiD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVLNGiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:38:03 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:43159 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750902AbVLNGiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:38:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZZlbu7bEl34k6oRjBZCp3LNCdofrQmTAXmzW4jAnBhVpDgeF3StXZti7jvVkuTvIT74SfR1gHC4sllvw+jSvfEIT2rhNmeOYT4eq3ceYNNGb5C284NaKxdDeR3CBSodA5dgxK57gjn7HuyLtX/pG8FbAs8dGvvZE1z9HVobGO8w=
Message-ID: <439FBDC5.5060609@gmail.com>
Date: Wed, 14 Dec 2005 14:37:57 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Kurt Wall <kwallinator@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Console Goes Blank When Booting 2.6.15-rc5
References: <200512132247.54341.kwallinator@gmail.com>
In-Reply-To: <200512132247.54341.kwallinator@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Wall wrote:
> As Jesper Juhl has reported, if I boot 2.6.15-rc5 with vga=normal,
> everything is fine. If I boot using my preferred size (vga=794),
> the console goes blank. Because I'm a touch typist, I can login and
> start X and everything is copacetic, but as soon as I leave X, I'm
> back to the blank screen. From X, if I flip over to a VC, the VC
> display is garbled and has artifacts from the X display.
> 
> This worked fine with 2.6.14.3, and I didn't change the console, 
> framebuffer, or vesa options between the two kernels. Not sure how 
> to proceed, but I sure would like my high res console screens back.

Can you recheck your .config and make sure that
CONFIG_FRAMEBUFFER_CONSOLE=y

If that does not work, please post your dmesg and .config file.

Tony

