Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281739AbRKVUll>; Thu, 22 Nov 2001 15:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281740AbRKVUlc>; Thu, 22 Nov 2001 15:41:32 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:18415 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281739AbRKVUlO>; Thu, 22 Nov 2001 15:41:14 -0500
Date: Thu, 22 Nov 2001 20:41:02 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Message-ID: <20011122204102.E11821@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0111192340500.4079-100000@imladris.surriel.com> <Pine.LNX.4.33.0111200344080.1395-100000@behemoth.ts.ray.fi> <20011119194354.A10322@thune.mrc-home.com> <E1661rR-0001Vl-00@localhost> <20011119200503.B10322@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011119200503.B10322@thune.mrc-home.com>; from dalgoda@ix.netcom.com on Mon, Nov 19, 2001 at 08:05:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2001 at 08:05:03PM -0800, Mike Castle wrote:

> Dump does not reliably work with live file systems with 2.4.x

It doesn't work reliably on live filesystems on ANY kernel.  That
property is enhanced a bit by 2.4, that's all.  There's no way that a
block-level dump can do things like walk file indirect chains
atomically on a live filesystem, even with 2.2.

Cheers,
 Stephen
