Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWHSXKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWHSXKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 19:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWHSXKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 19:10:10 -0400
Received: from secure.htb.at ([195.69.104.11]:17170 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932557AbWHSXKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 19:10:08 -0400
Date: Sun, 20 Aug 2006 01:10:03 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Axel Kittenberger <axell@kittenberger.net>
Subject: Re: Abnormal HTTP request termination.
Message-Id: <20060820011003.0516411f.delist@gmx.net>
In-Reply-To: <44E782D5.4080402@kittenberger.net>
References: <44E782D5.4080402@kittenberger.net>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']kJW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Axel Kittenberger <axell@kittenberger.net> (Sat, 19 Aug 2006
23:29:57 +0200):
> Hello List

Hoi,
 
> On Linux 2.6 (exact 2.6.15) issuing a wget at this location 
> http://www.wohin-heute.at/highlights.php results in a truncated file. 
> Truncated before "</hmtl>.
> [...] 
> Since thats not a really important site, this is an academic question 
> after all :)
> 
> Has someone an idea, what may cause this network problem which seems
> to  be limited to linux 2.6?

Looks like it's /proc/s/n/ipv4/tcp_window_scaling. If it's turned off
the site comes through here. IIRC this is a known issue and there where
a few posts about that. You'll likely find them with keywords "tcp
window scaling" in the archive.

> Greetings,
> Axel Kittenberger

sl ritch
