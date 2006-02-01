Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWBAGeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWBAGeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 01:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWBAGeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 01:34:17 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:60612 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030542AbWBAGeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 01:34:16 -0500
Message-ID: <43E0567F.20004@t-online.de>
Date: Wed, 01 Feb 2006 07:34:39 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net
Subject: Re: [BUG] nfs version 2 broken
References: <43E05031.2000107@t-online.de> <1138774519.7861.4.camel@lade.trondhjem.org>
In-Reply-To: <1138774519.7861.4.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bVCT-TZaYec-rT2ZnRAXBENU7xLvNcCDt0Yw4k4bf4e6CfIJgHj1cV@t-dialin.net
X-TOI-MSGID: dfcceee1-ee47-4d47-a8a7-9fc192b59dc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust schrieb:

>What kind of server is this that you are using? The above message
>basically means that it is handing out inodes with a link count of 0.
>
>Cheers,
>  Trond
>  
>

Server:
=====

AOpen i915GMm-HFS with Pentium M, linux kernel 2.6.15-git7
running a system that startet as SuSE 9.2. Nfs-utils are still
the original 1.0.6, grep -i nfs linuxbuild/.config gives

    CONFIG_NFS_FS=y
    CONFIG_NFS_V3=y
    # CONFIG_NFS_V3_ACL is not set
    # CONFIG_NFS_V4 is not set
    # CONFIG_NFS_DIRECTIO is not set
    CONFIG_NFSD=y
    CONFIG_NFSD_V3=y
    # CONFIG_NFSD_V3_ACL is not set
    # CONFIG_NFSD_V4 is not set
    CONFIG_NFSD_TCP=y
    CONFIG_NFS_COMMON=y

Client
====

kernel build from the same source,

    CONFIG_NFS_FS=y
    CONFIG_NFS_V3=y
    # CONFIG_NFS_V3_ACL is not set
    # CONFIG_NFS_V4 is not set
    # CONFIG_NFS_DIRECTIO is not set
    CONFIG_NFSD=y
    CONFIG_NFSD_V3=y
    # CONFIG_NFSD_V3_ACL is not set
    # CONFIG_NFSD_V4 is not set
    CONFIG_NFSD_TCP=y
    CONFIG_ROOT_NFS=y
    CONFIG_NFS_COMMON=y

cu,
 Knut
