Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSDFPhH>; Sat, 6 Apr 2002 10:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293306AbSDFPhG>; Sat, 6 Apr 2002 10:37:06 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59638 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293035AbSDFPhF>; Sat, 6 Apr 2002 10:37:05 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020404223425.K11833@suse.de> 
To: Dave Jones <davej@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Sat, 06 Apr 2002 16:36:47 +0100
Message-ID: <22175.1018107407@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davej@suse.de said:
> With Marcelo using bk these days, is it possible that you can cherry
> pick certain csets from his bk tree ?

I couldn't work out how to make BK even attempt that. 

If you commit harmless and irrelevant changeset 'X' to a repository, then 
commit a completely separate changeset 'Y' which doesn't touch any of the 
same files, then it seems to be impossible¹ to import 'Y' into a different 
tree without also importing 'X'.

--
dwmw2

¹ Well, not quite, but Larry will probably hurt me if I let on how I 
actually managed it :)

