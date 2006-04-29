Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWD2RMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWD2RMB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 13:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWD2RMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 13:12:01 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:18600 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1750763AbWD2RMB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 13:12:01 -0400
Date: Sat, 29 Apr 2006 19:11:31 +0200
Message-Id: <1094007413@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: =?iso-8859-15?Q?Re:_another_kconfig_target_for_building_monolithic_ker?=
 =?iso-8859-15?Q?nel_(for_security)_=3F?=
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello !

do we need to have write access to /dev/kmem - especially on a server without X ?
iirc, write access can be disabled, for example with addons like grsecurity.
(don`t know what will be broken besides X, though)

regards
roland

> -----Ursprüngliche Nachricht-----
> Von: Dave Jones <davej@redhat.com>
> Gesendet: 29.04.06 18:43:41
> An: devzero@web.de
> CC: linux-kernel@vger.kernel.org
> Betreff: Re: another kconfig target for building monolithic kernel (for security) ?


> On Sat, Apr 29, 2006 at 03:03:55PM +0200, devzero@web.de wrote:
> 
>  > i want to harden a linux system (dedicated root server on the internet) by recompiling the kernel without support for lkm (to prevent installation of lkm based rootkits etc)
> 
> Loading modules via /dev/kmem is trivial thanks to a bunch of tutorials and
> examples on the web, so this alone doesn't make life that much more difficult for attackers.
> 
> 		Dave
> 
> -- 
> http://www.codemonkey.org.uk


_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192

