Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVLPLc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVLPLc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVLPLc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:32:27 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:56738 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751289AbVLPLc0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:32:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KUrVnfNu/Z2NjV8Cf5zALnr5IPlJJMdO6db/SKzTZzoyxuT3ildl5KbzbpCZy0947uiaNFDDNhEqfEqCD1Sd5/7WqYBWm9Qwp61j/OcGo6n8P/G9Mk/cfLtdQlvzOaC4ilnQ2vGKATxYDGogz/CYG8bJJUBfsQNZex1PDCjtxUs=
Message-ID: <eeb5c3c50512160332v3f026766w2c954f1482e84616@mail.gmail.com>
Date: Fri, 16 Dec 2005 12:32:25 +0100
From: Jim Meyering <meyering@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/3] *at syscalls: Intro
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <43A20B0B.5090205@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>
	 <43A20B0B.5090205@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, the rm in coreutils-cvs is finally thread-safe and race-free,
when using openat et al.

On 12/16/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Definitely gets my ACK, for my own motivations:  I want to create
> race-free cp(1)/mv(1)/rm(1) utilities for my posixutils project.
