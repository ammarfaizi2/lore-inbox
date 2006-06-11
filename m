Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWFKC6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWFKC6c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 22:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWFKC6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 22:58:32 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:63236 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932469AbWFKC6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 22:58:31 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <jdow@earthlink.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: VGER does gradual SPF activation (FAQ matter)
Date: Sat, 10 Jun 2006 19:58:24 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-reply-to: <192101c68d00$8c7d0dc0$0225a8c0@Wednesday>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 10 Jun 2006 19:54:03 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 10 Jun 2006 19:54:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Rather than inject emotions let's play a little bit with facts. This is
> excerpts from a SpamAssassin report for about 82000 emails.
>
> TOP SPAM RULES FIRED
> ------------------------------------------------------------
> RANK    RULE NAME              COUNT %OFRULES %OFMAIL %OFSPAM  %OFHAM
> ------------------------------------------------------------
>   49    SPF_SOFTFAIL           1804     0.42    2.20    8.31    0.01
>   72    SPF_HELO_PASS          1112     0.26    1.36    5.13   47.45
>   78    SPF_PASS                994     0.23    1.21    4.58   45.53
>   92    SPF_HELO_SOFTFAIL       772     0.18    0.94    3.56    0.03
>  113    SPF_FAIL                589     0.14    0.72    2.71    0.00
>  177    SPF_HELO_FAIL           352     0.08    0.43    1.62    0.00
>
> Stated from the opposite view
>
> TOP HAM RULES FIRED
> ------------------------------------------------------------
> RANK    RULE NAME              COUNT %OFRULES %OFMAIL %OFSPAM  %OFHAM
> ------------------------------------------------------------
>    5    SPF_HELO_PASS          28563     7.20   34.88    5.13   47.45
>    6    SPF_PASS               27409     6.90   33.47    4.58   45.53
>
> And so forth.
>
> People here should be smart enough to draw their own conclusions from
> raw data.

	Yeah, that you measured the wrong thing. SPF does not distinguish spam from
non-spam.

	What percentage of emails with forged sender addresses passed an SPF check?
What percentage of emails with forged sender addresses failed an SPF check?
What percentage of emails that correctly identified their senders passed an
SPF check? What percentage of emails that correctly identified their senders
failed an SPF check?

	SPF is an anti-forgery tool. It helps to prevent joe-jobs and false claims
of being the victim of a joe-job.

	DS


