Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031153AbWKPJ3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031153AbWKPJ3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031154AbWKPJ3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:29:32 -0500
Received: from raven.upol.cz ([158.194.120.4]:12700 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1031153AbWKPJ3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:29:31 -0500
Date: Thu, 16 Nov 2006 09:36:36 +0000
To: Auke Kok <sofar@foo-projects.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: git web (Re: nightly 2.6 LXR run?)
Message-ID: <20061116093636.GA19002@flower.upol.cz>
References: <1163530480.16381.23.camel@jcm.boston.redhat.com> <slrnelkj1s.7lr.olecom@flower.upol.cz> <455A4EF8.5030004@foo-projects.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455A4EF8.5030004@foo-projects.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 03:19:20PM -0800, Auke Kok wrote:
[]
> try to use `git2.kernel.org` instead of `git.kernel.org`. The second server 
> somehow only has an average load of ~4 instead of ~250.

Looking closer, i see all gitweb links (C) on both servers links are poining
to "www.kernel.org/git/?...". So, i thing there's no gitweb dup, only file
storage mirror.

BTW
,--
|olecom@flower:~$ host git.kernel.org
|git.kernel.org          CNAME   zeus-pub.kernel.org
|zeus-pub.kernel.org     A       204.152.191.37
|olecom@flower:~$ host git2.kernel.org
|git2.kernel.org         CNAME   zeus-pub2.kernel.org
|zeus-pub2.kernel.org    A       204.152.191.37
|olecom@flower:~$
`--
(maybe it's some way of multiplexing...)

And still "The load average on the server is too high".

:oE
____
