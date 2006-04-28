Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWD1UPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWD1UPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWD1UPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:15:31 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:33509 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751189AbWD1UPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:15:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=KcWyd8wdbJfClmhC+GCBsT07b7W86bjF6saLcP3SHUTtev3YRTcGUwSvg6DUCNO2AQyq7c8xzohSXyVL3JDHKMbj9xPQxzAP0h7TTDXZKWIhWlJR02N3w/QAv8Rxzn/CDeqJFX8ZLJj2VcU1WsiqCixDl+CYufwZqsNl1RVb7Es=
Date: Sat, 29 Apr 2006 00:13:19 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA sync
Message-ID: <20060428201319.GA7166@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.61.0604282112590.11398@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604282112590.11398@tm8103.perex-int.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 09:25:47PM +0200, Jaroslav Kysela wrote:
> Henrik Kretzschmar:
>       [ALSA] pcxhr - Fix a compiler warning on 64bit architectures

Use %zu instead.

