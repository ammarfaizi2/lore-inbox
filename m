Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTH0KGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTH0KGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:06:42 -0400
Received: from fep04.swip.net ([130.244.199.132]:56454 "EHLO
	fep04-svc.swip.net") by vger.kernel.org with ESMTP id S263279AbTH0KGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:06:38 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Bas Mevissen <ml@basmevissen.nl>
Subject: Re: generate modprobe.conf
Date: Wed, 27 Aug 2003 12:06:35 +0200
User-Agent: KMail/1.5.3
References: <200308271142.40104.cijoml@volny.cz> <3F4C81DD.6020608@basmevissen.nl>
In-Reply-To: <3F4C81DD.6020608@basmevissen.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271206.35069.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I load it manually and ifconfig it, device works...

I don't know why, coz 

alias eth0 3c59x

and

alias char-major-13 hid
post-install hid modprobe -k mousedev; modprobe -k input

is a standart way...isn't it?

M.

Dne st 27. srpna 2003 12:03 jste napsal(a):
> Michal Semler (volny.cz) wrote:
> > Hi,
> >
> > I tried generate modprobe.conf from my modules.conf, but without success.
> > My ethernet card and mouse doesn't work - theitr modules are not loaded
> > in startup. Where is problem?
>
> Please try something like "modprobe eth0" or "ifup eth0" and see/e-mail
> what you see in /var/log/messages.
>
> Regards,
>
> Bas.

