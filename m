Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273304AbRINFRa>; Fri, 14 Sep 2001 01:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRINFRV>; Fri, 14 Sep 2001 01:17:21 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:39107
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S273304AbRINFRM>; Fri, 14 Sep 2001 01:17:12 -0400
Date: Thu, 13 Sep 2001 22:17:36 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: Colin Frank <kernel@osafo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Compining NetFilter: depmod, undefined symbols in 2.4.9
In-Reply-To: <3BA17C7B.9090307@osafo.com>
Message-ID: <Pine.LNX.4.33.0109132216360.12327-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, Colin Frank wrote:

> There seems to be a mismatch with /System.map and /proc/ksyms
> form the coorresponding kernel.
> make bzlilo; make modules; make modules_install, and boot on the
> /vmlinuz kernel.

It means you either didn't do make clean, or make clean wasn't good enough
and you needed to copy the .config away, make mrproper, and copy the
config back.


justin

