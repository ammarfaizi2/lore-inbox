Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTEBBoD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbTEBBoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:44:03 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:23054 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262865AbTEBBoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:44:02 -0400
Date: Thu, 1 May 2003 22:56:34 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: hv-it <hv@trust-mart.com.cn>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at net/socket.c:147
Message-ID: <20030502015634.GD5356@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	hv-it <hv@trust-mart.com.cn>, arjanv@redhat.com,
	linux-kernel@vger.kernel.org
References: <1051821220.4440.1.camel@mharnois.mdharnois.net> <1051821952.1407.6.camel@laptop.fenrus.com> <20030502050451.5b742a0a.hv@trust-mart.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502050451.5b742a0a.hv@trust-mart.com.cn>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 02, 2003 at 05:04:51AM +0800, hv-it escreveu:
> This is happened with 2.5.68-bkx(x>=5),I think it's a protocol's bug with net_family_get and net_family_put in bkx's patch.

Yes, it is a bug, but in _vmware_ :-) You can leave the patch, just delete the
net_family_bug call in net_family_get

> I use 2.5.68-bk11 which I have deleted net_family-get and net_family_put.All is fine to me.
> My vmware's version is 4.

Interesting thing is that I tested this with... vmware 4, but not in bridged
mode.

- Arnaldo
