Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264916AbSJ3V1C>; Wed, 30 Oct 2002 16:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSJ3V1C>; Wed, 30 Oct 2002 16:27:02 -0500
Received: from d196069.dynamic.cmich.edu ([141.209.196.69]:58001 "EHLO euclid")
	by vger.kernel.org with ESMTP id <S264916AbSJ3V1B> convert rfc822-to-8bit;
	Wed, 30 Oct 2002 16:27:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Matthew J. Fanto" <mattf@mattjf.com>
Reply-To: mattf@mattjf.com
Organization: mattjf.com
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: The Ext3sj Filesystem
Date: Wed, 30 Oct 2002 16:33:16 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200210301434.17901.mattf@mattjf.com> <20021030200020.GV28982@clusterfs.com>
In-Reply-To: <20021030200020.GV28982@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210301633.16910.mattf@mattjf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 03:00 pm, Andreas Dilger wrote:

> 1) having so many encryption algorithms is a huge pain in the ass, and
>    it will never be accepted into the kernel like that.  Pick some
>    "good" encryption algorithms (like those that will be supported as
>    part of IPSec and/or the encrypted loop devices: 3DES, AES, RC5 or
>    whatever) and then there can be some re-use with other parts of the
> kernel. 

I don't believe having so many algorithms is such a pain. It gives users more 
choices. I've spoke to people who will not trust AES, 3DES, SHA, and even 
the AES finalists because they believe NIST/NSA only picked weak algorithms. 
Obviously there will be a default algorithm (probably AES and SHA1), so I 
don't think having more algorithms will cause users problems. Only problem I 
see is maintaining all of them.

-Matthew J. Fanto

