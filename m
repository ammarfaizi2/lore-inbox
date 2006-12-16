Return-Path: <linux-kernel-owner+w=401wt.eu-S1753752AbWLPOAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbWLPOAJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 09:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbWLPOAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 09:00:09 -0500
Received: from main.gmane.org ([80.91.229.2]:57026 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754AbWLPOAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 09:00:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Followup-To: gmane.comp.version-control.git
Date: Sat, 16 Dec 2006 14:59:40 +0100
Organization: At home
Message-ID: <em0u4k$8hs$1@sea.gmane.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:

> Things that need to be done to complete what have been merged to
> 'master' are:

What about discussed but not implemented moving restriction on non-head refs
from git-checkout (forbidding to checkout tags, remotes, and arbitrary
commits like HEAD~n) to git-commit (allowing commiting only to heads refs)?
Probably non-heads refs should be saved in HEAD as explicit sha1 of a
commit; this way we wont run into situation where HEAD changed under us
(because it was for example to remote branch, and we fetched since).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git


