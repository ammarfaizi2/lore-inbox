Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265016AbUFAM1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbUFAM1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFAM1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:27:41 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:51465 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S265017AbUFAM1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:27:39 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>
Subject: Re: why swap at all?
Date: Tue, 1 Jun 2004 14:27:33 +0200
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> <20040531104928.GA1465@ncsu.edu> <40BC6F0C.7000602@vision.ee>
In-Reply-To: <40BC6F0C.7000602@vision.ee>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200406011427.33770.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 June 2004 13.57, Lenar Lõhmus wrote:
> jlnance@unity.ncsu.edu wrote:
> >I'm not sure.  Copying a file is a pretty good indication that you
> >are about to do something with either the new or the old file.
>
> Like taking the new file with me on USB dongle and deleting old one?
> Caching the file really doesn't help in this case.

No, and most file copies are not to be used in the "near" future. I.e. on
my machine. Caching on the second read (close in time) is ok, or if there
are unused ram, but paging out things in use is bad. It's much more likely
that the page allocated to a program will be used than a newly read or written 
file.

Ofcourse your milega may vary. I'm thinking of my desktop now.

-- robin
