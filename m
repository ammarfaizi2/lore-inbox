Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbTIDGxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTIDGxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:53:53 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:29889 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S264736AbTIDGxw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:53:52 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Re: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Date: Thu, 4 Sep 2003 09:53:44 +0300
Message-ID: <2C83850C013A2540861D03054B478C0601CF64F6@hasmsx403.iil.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Thread-Index: AcNyrkUvZTB1AvgFT/SbybLF8OGwUwAACeTg
From: "Zach, Yoav" <yoav.zach@intel.com>
To: <insecure@mail.od.ua>
Cc: <akpm@osdl.org>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2003 06:53:44.0908 (UTC) FILETIME=[489618C0:01C372B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- insecure <insecure@mail.od.ua> wrote:
>
> > If the binary resides on a NFS drive ( which 
> > is a very common practice )
> > then the suid-wrapper solution will not work 
> > because root permissions
> > are squashed on the remote drive.
> 
> 
> This is a NFS promlem. Do not work around it by
> adding crap elsewhere.
> NFS has to get a decent user auth/crypto features.
> I did not try it yet, but NFSv4 will address that.
> --

This is not a workaround - it's a solution for systems
that use the unix user identification mechanism.
Considering the conservative nature of system-administrators,
this mechanism will still be in use for quite a while.

Thanks,
Yoav.
