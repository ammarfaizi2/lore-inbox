Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRIIGjH>; Sun, 9 Sep 2001 02:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271913AbRIIGis>; Sun, 9 Sep 2001 02:38:48 -0400
Received: from vitelus.com ([64.81.243.207]:3850 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S271911AbRIIGio>;
	Sun, 9 Sep 2001 02:38:44 -0400
Date: Sat, 8 Sep 2001 23:38:59 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: John Kacur <jkacur@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre6, NTFS build break
Message-ID: <20010908233859.A4284@vitelus.com>
In-Reply-To: <Pine.LNX.4.33.0109081949510.1097-100000@penguin.transmeta.com> <3B9AFE23.ACB3023E@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B9AFE23.ACB3023E@home.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 01:29:07AM -0400, John Kacur wrote:
> Perhaps this can just be turned into
> static inline ntfs_debug(mask, fmt, ...)	do {} while(0)

You mean static inline ntfs_debug(mask,fmt,...) { }

but it should probably also work as

#define ntfs_debug(mask, fmt...) do {} while(0)
