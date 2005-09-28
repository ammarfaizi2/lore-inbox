Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVI1VBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVI1VBb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVI1VBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:01:31 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:3016 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750891AbVI1VBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:01:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KYTF5jVDa8yNRItP5Dj9BxutEQcW79KiN4RgrZtYzEK4Kcu2IDOOfoEQv6EEXw10jJSTX5cTHCP6DggmRW3KjzkvEjmjBdqWjp0dsQBMhy6+4OSEihsi7N3l9Ys3125Hn0fP0OdmspIJCWwZnpeAtrllPBemQIWf5fYciKCuyCo=
Message-ID: <433B049B.1090502@gmail.com>
Date: Thu, 29 Sep 2005 05:01:15 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net>
In-Reply-To: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> Hello all,
> 

> * I have thus tried the new nvidiafb driver, which seems to work ok,
> except for the minor detail that the display is extremely snowy.
> Attempts to change the timing options with fbset fail: fbset seems to
> accept the settings, no error message is given, but nothing is
> changed. The X nv driver select the correct timings, so I tried
> modeline2fb to make fbset use those, but still nothing changes.
> 

What's the dmesg output?  What's fbset -i output?

Can you try doing fbset -accel false and see if it makes a difference?

Tony

