Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVGGRti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVGGRti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVGGRrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:47:47 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:13749 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261363AbVGGRre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:47:34 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: reiser4 plugins
Date: Thu, 7 Jul 2005 17:47:31 +0000 (UTC)
Organization: Cistron
Message-ID: <dajprj$e9c$1@news.cistron.nl>
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <20050701155446.GZ16867@khan.acc.umu.se> <20050707082749.GZ11013@nysv.org> <42CD3580.4020008@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: ncc1701.cistron.net 1120758451 14636 194.109.0.112 (7 Jul 2005 17:47:31 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <42CD3580.4020008@slaphack.com>,
David Masover  <ninja@slaphack.com> wrote:
>Markus Törnqvist wrote:
>> Anyway, I don't really like the metafs thing.
>> 
>> To access the data, you still need to refactor userspace,
>> so that's not a real advantage. Doing lookups from /meta
>> all the time, instead of in the file-as-dir-whatever...
>
>I don't really see the disadvantage.
>
>Also, metafs means much less of a fight to get people to adopt the whole 
>meta concept, because it can be done in a POSIX-compliant way which 
>doesn't break tar.
>
>File-as-dir is nice if you're using meta files, but it causes lots of 
>unexpected weirdness.  I don't think metafs costs us much in 
>performance, and with one or two shell scripts, it wouldn't cost us that 
>much efficiency on the commandline.

file-as-dir is an innovation. Metafs is an ugly compromise.

Mike.

