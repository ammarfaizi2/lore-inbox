Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbUK0Axm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbUK0Axm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbUK0Aum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:50:42 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:20887 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262402AbUKZX4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 18:56:08 -0500
Date: Sat, 27 Nov 2004 00:56:00 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, dwmw2@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <19865.1101395592@redhat.com>
Message-ID: <Pine.LNX.4.60.0411270049520.29718@alpha.polcom.net>
References: <19865.1101395592@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2004, David Howells wrote:

>     (b) Make kernel file #include the user file.

Does kernel really need to include user headers? When it is definition of 
some const then it should be defined in one file (to be sure it has only 
one definition). But user headers may have some compatibility hacks that 
kernel do not need (and even maybe does not want) to have.

How you will handle that?


Thanks,

Grzegorz Kulewski

