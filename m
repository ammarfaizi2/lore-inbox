Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268341AbTBSKkn>; Wed, 19 Feb 2003 05:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268343AbTBSKkn>; Wed, 19 Feb 2003 05:40:43 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:24083 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S268341AbTBSKkm>;
	Wed, 19 Feb 2003 05:40:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Module problems (WAS: RE: 2.5.62 on Alpha SUCCESS (2.6 release soon!?))
References: <008001c2d7ff$aa12b420$020b10ac@pitzeier.priv.at>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 19 Feb 2003 11:50:44 +0100
In-Reply-To: "Oliver Pitzeier"'s message of "Wed, 19 Feb 2003 11:14:13 +0100"
Message-ID: <yw1xisvgk0hn.fsf@manganonaujakasit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Oliver Pitzeier" <o.pitzeier@uptime.at> writes:

> > > OK... Make modules_install still has problems:
> [ ... ]
> > Which versions of binutils and gcc do you have?  I get 
> > similar problems with binutils 2.13 and 2.4 kernels.
> 
> This is my current env.:
> [root@track /root]# rpm -q modutils binutils gcc
> modutils-2.4.22-8
> binutils-2.12.90.0.7-3
> gcc-3.1-6
> 
> Maybe I should upgrade gcc? But I believe 3.1 is working fine... At
> least for my normally...

I got those relocation errors when using gcc 3.1 and too old modutils,
but you seem to have the latest version.  Try changing to binutils
2.12.  It works for me, but 2.13 doesn't.

-- 
Måns Rullgård
mru@users.sf.net
