Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318709AbSICOjM>; Tue, 3 Sep 2002 10:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318722AbSICOjM>; Tue, 3 Sep 2002 10:39:12 -0400
Received: from relay.muni.cz ([147.251.4.35]:18128 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S318709AbSICOjL>;
	Tue, 3 Sep 2002 10:39:11 -0400
Date: Tue, 3 Sep 2002 16:43:37 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID5 checksum algorithm selection
Message-ID: <20020903164337.A25155@fi.muni.cz>
References: <20020903161846.J18187@fi.muni.cz> <20020903144101.GA20593@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020903144101.GA20593@middle.of.nowhere>; from thunder7@xs4all.nl on Tue, Sep 03, 2002 at 04:41:01PM +0200
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:
: Try the source, there's a comment at the end of include/i386/xor.h that
: explains (not in great detail, but perhaps google or another archive can
: help there?).

	It explains the reason perfectly for me - to try to avoid
the cache pollution. Thanks for pointing me to the right direction.

-Y. 

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
       Pruning my incoming mailbox after being 10 days off-line,
       sorry for the delayed reply.
