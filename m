Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVKBX2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVKBX2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVKBX2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:28:42 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:25205 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030191AbVKBX2l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:28:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sTTiNb77erLlmH4vdFPmz4ij25yotMy7EjxCl8Dmah9ytGapF/rxlv44tLE5JNJwqWIQkhSdT5xHcdx+nAE8y/ug87SfgRQW3XA9wBfYGyUpm/IaJg0G+EDoA5CQkkf58o7OHAzEGm+UIQepv74lugdsfBFUJeSCwPvuwB3ppQE=
Message-ID: <39e6f6c70511021528u513a9b4fn44497ddb2f672a28@mail.gmail.com>
Date: Wed, 2 Nov 2005 21:28:40 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Yan Zheng <yanzheng@21cn.com>
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Stevens <dlstevens@us.ibm.com>
In-Reply-To: <43694B94.7010605@21cn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <OF395F8772.5B834BF9-ON882570AC.0075ACD7-882570AC.0075DC3C@us.ibm.com>
	 <4367FF22.3030601@21cn.com>
	 <39e6f6c70511021355i52aff7e4n19ca4c1e24b21bb7@mail.gmail.com>
	 <43694B94.7010605@21cn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Yan Zheng <yanzheng@21cn.com> wrote:
> >
> > Could you please compile test it next time :-) hint, missing ';'.
> > Anyway, fixed up by hand.
> >
> > - Arnaldo
> >
> >
>
> I'm so sorry.

Don't worry, I already fixed it and published in my net-2.6.git tree at
www.kernel.org, its just that the same confidence that makes one
commit something simple as in your case could introduce something
nasty :-)

- Arnaldo
