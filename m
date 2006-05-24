Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbWEXR4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWEXR4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWEXR4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:56:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:23214 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932752AbWEXR4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:56:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 4096 byte limit to /proc/PID/environ ?
Date: Wed, 24 May 2006 10:56:24 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e526o8$q4k$1@terminus.zytor.com>
References: <447481C0.5050709@moving-picture.com> <Pine.LNX.4.61.0605241235110.2450@chaos.analogic.com> <447490EF.8010000@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148493384 26773 127.0.0.1 (24 May 2006 17:56:24 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 24 May 2006 17:56:24 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <447490EF.8010000@moving-picture.com>
By author:    James Pearson <james-p@moving-picture.com>
In newsgroup: linux.dev.kernel
> 
> I'm not worried about that - more the fact that when I do:
> 
> % cat /proc/$$/environ | wc -c
> 4096
> % env | wc -c
> 7329
> 
> /proc/PID/environ is truncated ...
> 

Funny enough, I was looking at this yesterday.  I think there is a
pretty clean solution for it, I just haven't had a chance to attack it
yet.

	-hpa

