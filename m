Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbTANPkk>; Tue, 14 Jan 2003 10:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbTANPkk>; Tue, 14 Jan 2003 10:40:40 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:39460 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S264614AbTANPkg>; Tue, 14 Jan 2003 10:40:36 -0500
Date: Tue, 14 Jan 2003 16:48:59 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: ext3 users list <ext3-users@redhat.com>, akpm@zip.com.au,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: 2.4.21-pre3 - problems with ext3
In-Reply-To: <1042557354.5427.164.camel@sisko.scot.redhat.com>
Message-ID: <Pine.LNX.4.51.0301141645070.2887@lt.wsisiz.edu.pl>
References: <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
 <1042557354.5427.164.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, Stephen C. Tweedie wrote:

> Hi,
> 
> On Tue, 2003-01-14 at 13:15, Lukasz Trabinski wrote:
> 
> > Jan 14 12:53:52 oceanic kernel: Code: 0f 0b f9 00 f4 4f 8b f8 ff 43 08 89 d8 8b 5c 24 14 8b 74 24 
> 
> That's a BUG(), and you should have had some form of ext3 or jbd assert
> failure in the logs just before this oops --- could you supply that,
> please?

Here is:

Jan 14 12:53:52 oceanic kernel: Assertion failure in
 journal_start_Rsmp_909c88ec() at transaction.c:249:
 "handle->h_transaction->t_journal == journal"
Jan 14 12:53:52 oceanic kernel: kernel BUG at transaction.c:249!
Jan 14 12:53:52 oceanic kernel: invalid operand: 0000
Jan 14 12:53:52 oceanic kernel: CPU:    1

Thank You for your answer.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
