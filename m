Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbVKXV1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVKXV1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 16:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVKXV1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 16:27:53 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:7661 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932665AbVKXV1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 16:27:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RyTexiDVev+FIFYu4hNe3icbFKqd14/H0MAVqLzlus++Wtv0PvYa3SbK8NPiOu77MoyPN7Lblus5OmuGlVBBERVa1C4JhKKAqEGvj34kuz1aoXUjH5GoWkH4hCPLioiGiCfpCsnsiYLpEDZenR0/4lebNX2JiCP4KZxjuk8beNI=
Message-ID: <43863050.3030407@gmail.com>
Date: Fri, 25 Nov 2005 05:27:44 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Jasper Spaans <jasper@vs19.net>
CC: linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fbcon: fix obvious bug in fbcon logo rotation code
References: <20051124155336.GA7119@spaans.vs19.net>
In-Reply-To: <20051124155336.GA7119@spaans.vs19.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jasper Spaans wrote:
> From: Jasper Spaans <jasper@vs19.net>
> 
> This code fixes a tiny problem with the recent fbcon rotation changes:
> fb_prepare_logo doesn't check the return value of fb_find_logo and that
> causes a crash for my while booting.
> 
> Obvious & working & tested fix is here.
> 
> Signed-off-by: Jasper Spaans <jasper@vs19.net>

Acked-by: Antonino Daplas <adaplas@pol.net>
