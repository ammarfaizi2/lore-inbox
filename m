Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVANWwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVANWwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVANWu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:50:59 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:64573 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261398AbVANWss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:48:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gKI2JH8imJC8OgLqZ6x2yv4DjxDpbmbOM0UjBYRYaYDofzgoCcSJQZvZl1R2GGiBFinvqphE9JA2CcxjPRRkVoOnJsbpJY5kINh9RyF/V86feARskGrw2I5bxqHYtUcAu3K6QvC1vpbp7AeRznq/t+tJLREFdyMaPpWhaf8Qonc=
Message-ID: <7f800d9f050114144859c46b4b@mail.gmail.com>
Date: Fri, 14 Jan 2005 14:48:44 -0800
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc1-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050114002352.5a038710.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005 00:23:52 -0800, Andrew Morton <akpm@osdl.org> wrote:
> - Added FUSE (filesystem in userspace) for people to play with.  Am agnostic
>   as to whether it should be merged (haven't read it at all closely yet,
>   either), but I am impressed by the amount of care which has obviously gone
>   into it.  Opinions sought.

This is great news!

As a long time user of KDE's kio-slaves, I was always missing the
kio-slave functionality on the command line and in non-kde programs.
FUSE provides a kio-slave interface, but hopefully the inclusion of
FUSE in the mm-kernel  will cause more "fuse native" filesystems to
come out which provide the functionality of the various kio-slaves.

Some things I'd like to see (as I am currently using the KIO
equivalent) implemented as FUSE fs:
- "fish", virtual file access over ssh
- "audiocd", virtual audio cd filesystem which copies and encodes
audio tracks on the fly
- "ftp", virtual file system ftp server access
etc..

Imagination is the limit, and since it can be implemented in userspace
pretty easily with FUSE, I am looking forward to see what people can
come up with and hope that FUSE is here to sray.

Cheers,
   Andre
