Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWJWLix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWJWLix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWJWLiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:38:52 -0400
Received: from brick.kernel.dk ([62.242.22.158]:1816 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932080AbWJWLiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:38:51 -0400
Date: Mon, 23 Oct 2006 13:39:56 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.4.3.1
Message-ID: <20061023113956.GN8251@kernel.dk>
References: <7v4ptyi68s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7v4ptyi68s.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20 2006, Junio C Hamano wrote:
> The latest maintenance release GIT 1.4.3.1 is available at the
> usual places:
> 
>   http://www.kernel.org/pub/software/scm/git/
> 
>   git-1.4.3.1.tar.{gz,bz2}			(tarball)
>   git-htmldocs-1.4.3.1.tar.{gz,bz2}		(preformatted docs)
>   git-manpages-1.4.3.1.tar.{gz,bz2}		(preformatted docs)
>   RPMS/$arch/git-*-1.4.3.1-1.$arch.rpm	(RPM)
> 
> This is primarily to work around changes in the recent GNU diff output
> format.  Also it contains irritation fix for "git diff" which now
> paginates its output by default.
> 
> ----------------------------------------------------------------
> 
> Changes since v1.4.3 are as follows:
> 
> Junio C Hamano (1):
>       pager: default to LESS=FRS

It still behaves badly, git diff still shows my an empty pager waiting
for 'q', while LESS=FRS git diff works as desired.

git version 1.4.3.1.g87b78

-- 
Jens Axboe

