Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283267AbRLROTz>; Tue, 18 Dec 2001 09:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283756AbRLROTp>; Tue, 18 Dec 2001 09:19:45 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:9956 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S283267AbRLROTf>; Tue, 18 Dec 2001 09:19:35 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: modify_ldt returning ENOMEM on highmem
Date: Tue, 18 Dec 2001 15:19:34 +0100
Organization: Internet Factory AG
Message-ID: <3C1F5076.3B6A509E@internet-factory.de>
In-Reply-To: <200112171852.fBHIqJR05703@orp.orf.cx>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1008685174 12978 195.122.142.158 (18 Dec 2001 14:19:34 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 18 Dec 2001 14:19:34 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac7 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leigh Orf proclaimed:
> Do you have an NTFS disk mounted? I had a similar problem which was
> "fixed" by not having an NTFS vol mounted. Apparently the ntfs code
> makes a lot of calls to vmalloc which leads to badness.

Yes, I have. I'll try not mounting it. Which would be a better
workaround than disabling 1/8 of my RAM.
The funny thing is just - why does it work fine with up to 896 MB, but
gives ENOMEM with _more_ RAM?

Holger
