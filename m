Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132762AbRC2QKN>; Thu, 29 Mar 2001 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbRC2QKE>; Thu, 29 Mar 2001 11:10:04 -0500
Received: from 8.ylenurme.ee ([193.40.6.8]:39172 "EHLO ns.linking.ee")
	by vger.kernel.org with ESMTP id <S132762AbRC2QJ6>;
	Thu, 29 Mar 2001 11:09:58 -0500
Message-ID: <3AC35E17.12DAC3C5@linking.ee>
Date: Thu, 29 Mar 2001 18:08:56 +0200
From: Elmer Joandi <elmer@linking.ee>
Organization: Linking =?iso-8859-1?Q?O=DC?=
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: OOPS: reiserfs, 2.4.2-ac26 SMP
In-Reply-To: <120820000.985791904@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>
> Most likely compiled with redhat gcc 2.96.  Please upgrade to their latest,
> or use kgcc.

Ok, after
    1. upgrading redhat gcc
    2. applying that BKL in vmtruncate minipatch

now it copies about 50MB before cp gets stuck on do_journal



2.4.0 with reiserfs patch and reiserfs quota patch just works (not the quota
part yet).



