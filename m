Return-Path: <linux-kernel-owner+w=401wt.eu-S964922AbWLTGmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWLTGmP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 01:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWLTGmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 01:42:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:50107 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922AbWLTGmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 01:42:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PfBZf7mb1ocxoOx0vXElwHclyJv1UDH4gRQ5472lTUzmQvyMHbvKb11Fdzi8NEAXbY5O06BWYWOMPvPHdH7HJx+2zskRbBTVfBKD5rev0utYPJWaMBx2k7ywFUyR3NrNQe9OGeKJjV2qfyD4EBNvecPTutNOPXrpt0QDapbNbcg=
Message-ID: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
Date: Wed, 20 Dec 2006 01:42:13 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: kzak@redhat.com, hvogel@suse.de, olh@suse.de, hpa@zytor.com,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de, arekm@maven.pl,
       util-linux-ng@vger.kernel.org
Subject: Re: util-linux: orphan
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Zak writes:

> I've originally thought about util-linux upstream fork,
> but as usually an fork is bad step. So.. I'd like to start
> some discussion before this step.
...
> after few weeks I'm pleased to announce a new "util-linux-ng"
> project. This project is a fork of the original util-linux (2.13-pre7).

Aw damn, I missed it again. LKML gets about 300 posts/day. The last
time util-linux was offered, I missed out. Bummer.

Well, how about giving me a chunk of it? I'd like /bin/kill please.
I already ship a nicer one in procps anyway, so you can just delete
the files and call that done. (just today I was working on a Fedora
system and /bin/kill annoyed me)

VERY STRONG SUGGESTION: build a full test suite before you mess with
the source. This isn't some cute toy like xeyes or a silly game.
This is util-linux, which MUST work.
