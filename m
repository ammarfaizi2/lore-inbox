Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVITAVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVITAVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 20:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVITAVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 20:21:23 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:4597 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964795AbVITAVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 20:21:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Xax3VxoFv1MIfEWsHftNkrNtiIcuiuRsuAR5f04HR++wQhi6oOEUab6PslsbEIOPol9dMCVdzUX6CEFYWBUl5lUejGnfb0d5KLuVspdI3xAdMgekFwblMOKHJenwilI42zMY5RHeVco/AyFlOg7TD7Wldb0k599TACf7jDQSvIA=
Message-ID: <432F55E0.70304@gmail.com>
Date: Tue, 20 Sep 2005 08:20:48 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Jan Dittmer <jdittmer@ppp0.net>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net> <432F36B4.8030209@gmail.com> <Pine.LNX.4.56.0509200030280.611@pentafluge.infradead.org>
In-Reply-To: <Pine.LNX.4.56.0509200030280.611@pentafluge.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> the hwcur module parameter is set to off by default. Should it be removed?
> 

The hardware cursor for newer chipsets (NV20 and above?) is not very
nice to the eyes.  When the cursor is moved, the old cursor image does
not disappear immediately, but kinda fades away.  I believe it is an
nvidia special effect for mouse pointer trails. Cool when in graphics, but
irritating when in text mode.

So, no, let's leave hwcur to 0.

Tony
