Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUIUQo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUIUQo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUIUQo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:44:29 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:44465 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S267799AbUIUQo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:44:28 -0400
Message-ID: <41505AA1.A51DEE50@users.sourceforge.net>
Date: Tue, 21 Sep 2004 19:45:21 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> People have asked repeatedly for a way to mark lines in /etc/fstab
> so as to make clear that such lines are managed by some GUI or other
> external program. Labels like "kudzu".
> In this release I added a comment convention for /etc/fstab: options
> can have a part starting with \; - that part is ignored by mount
> but can be used by other programs managing fstab.

How about implementing /etc/fstab option parsing code that is compatible
with existing libc /etc/fstab parsing code:

defaults,noauto,comment=kudzu,rw
                ^^^^^^^^^^^^^

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
