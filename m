Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRIUKk4>; Fri, 21 Sep 2001 06:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273302AbRIUKkq>; Fri, 21 Sep 2001 06:40:46 -0400
Received: from ns.suse.de ([213.95.15.193]:51717 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S273261AbRIUKke> convert rfc822-to-8bit;
	Fri, 21 Sep 2001 06:40:34 -0400
To: Dirk =?iso-8859-1?q?F=F6rsterling?= <dirk.foersterling@eorga.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stdin/pipe problem with kernel 2.4.9
In-Reply-To: <3BA9D8F8.5000801@eorga.com>
X-Yow: Yow!  Is my fallout shelter termite proof?
From: Andreas Schwab <schwab@suse.de>
Date: 21 Sep 2001 12:40:56 +0200
In-Reply-To: <3BA9D8F8.5000801@eorga.com> (Dirk
  =?iso-8859-1?q?F=F6rsterling's?= message of "Thu, 20 Sep 2001 13:54:32
  +0200")
Message-ID: <jebsk4j07b.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.106
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Försterling <dirk.foersterling@eorga.com> writes:

|> I repost this because you may have been distracted by the date contained
|> in the old subject line. So far there was no response at all. No hint,
|> no trick, no RTFM (pointers?) or whatever. So far I wasn't able to find
|> anything related using google, the kernel docs and the linux-kernel archive.
|> The SuSE support won't help me with 2.4 and the support database doesn't contain
|> any (findable) article related to my problem. So I decided to repost my question.

This has nothing to do with the kernel, it's a problem with some versions
of cron (which closes stdin/out/err at startup instead of redirecting them
to /dev/null and subsequently gets confused when spawning the jobs).

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
