Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbTCOVMu>; Sat, 15 Mar 2003 16:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbTCOVMt>; Sat, 15 Mar 2003 16:12:49 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:56468 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261573AbTCOVL0>; Sat, 15 Mar 2003 16:11:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Sat, 15 Mar 2003 22:26:05 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311192639.E72163C5BE@mx01.nexgo.de> <20030314122903.GC8057@zaurus.ucw.cz>
In-Reply-To: <20030314122903.GC8057@zaurus.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030315212217.0ADAC10D59D@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Mar 03 13:29, Pavel Machek wrote:
> What kind of data would have to be in soft-changeset?
> * unique id of changeset
> * unique id of previous changeset
> (two previous if it is merge)
> ? or would it be better to have here
> whole path to first change?
> * commit comment
> * for each file:
> ** diff -u of change
> ** file's unique id
> ** in case of rename: new name (delete is rename to special dir)
> ** in case of chmod/chown: new permissions
> ** per-file comment

This *very* closely matches the schema I worked up some months ago, and 
dusted off again when I saw your original Bitbucket post.

> ? How to handle directory moves?
>
> Does it seem sane? Any comments?

Oh yes.  Comment: see response to Horst van Brand, on much the same subject.

Regards,

Daniel
