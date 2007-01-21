Return-Path: <linux-kernel-owner+w=401wt.eu-S1751741AbXAUWpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbXAUWpT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 17:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbXAUWpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 17:45:19 -0500
Received: from main.gmane.org ([80.91.229.2]:51660 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbXAUWpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 17:45:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Followup-To: gmane.comp.version-control.git
Date: Sun, 21 Jan 2007 23:45:07 +0100
Organization: At home
Message-ID: <ep0qc6$bph$1@sea.gmane.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Schindelin wrote:

> On Sun, 21 Jan 2007, Junio C Hamano wrote:

>> * Reflog
>> 
>>  - Reflog records the history of where the tip of each branch
>>    was at each moment.
> 
> It might make sense to reformulate that:
> 
>       Reflog records the history from the view point of the local 
>       repository. In other words, regardless of the real history,
>       the reflog shows the history as seen by one particular repository
>       (this enables you to ask "what was the current revision in _this_
>       repository, yesterday at 1pm?").

I think that _both_ sentences are right. Reflog records history of where the
tip of each branch was at each moment, logging also what command was used
to move tip of branch (was it commit, amending commit, rebase, reset, or
creating branch anew, git-am or pull).

But where tip of each branch was is purely local matter. What is global
is DAG of commits, refs are always as seen by one particular repository.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git


