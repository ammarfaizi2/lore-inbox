Return-Path: <linux-kernel-owner+w=401wt.eu-S1030191AbWLTQVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWLTQVG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 11:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWLTQVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 11:21:05 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:39839 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030191AbWLTQVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 11:21:04 -0500
Date: Wed, 20 Dec 2006 17:13:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Cahalan <acahalan@gmail.com>
cc: kzak@redhat.com, hvogel@suse.de, olh@suse.de, hpa@zytor.com,
       linux-kernel@vger.kernel.org, arekm@maven.pl,
       util-linux-ng@vger.kernel.org
Subject: Re: util-linux: orphan
In-Reply-To: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612201712190.15218@yvahk01.tjqt.qr>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I've originally thought about util-linux upstream fork,
>> but as usually an fork is bad step. So.. I'd like to start
>> some discussion before this step.
> ...
>> after few weeks I'm pleased to announce a new "util-linux-ng"
>> project. This project is a fork of the original util-linux (2.13-pre7).
>
> Well, how about giving me a chunk of it? I'd like /bin/kill please.
> I already ship a nicer one in procps anyway, so you can just delete
> the files and call that done. (just today I was working on a Fedora
> system and /bin/kill annoyed me)

How can you ship a "nicer" kill, given that its sole purpose is to accept

  kill { -l | -t | {-s SIGNUM | -SIGNAME } somepid [morepids] }

?

What about merging util-linux and procps?


	-`J'
-- 
