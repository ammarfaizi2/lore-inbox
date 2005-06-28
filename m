Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVF1ULQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVF1ULQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVF1UH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:07:57 -0400
Received: from smtpout.mac.com ([17.250.248.85]:55268 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261264AbVF1UE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:04:26 -0400
In-Reply-To: <42C1A5E8.2040603@slaphack.com>
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com> <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com> <42C06D59.2090200@slaphack.com> <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com> <42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca> <EBD8F590-0113-4509-9604-E6967C65C835@mac.com> <87mzpbrvpf.fsf@evinrude.uhoreg.ca> <D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com> <87irzzrqu7.fsf@evinrude.uhoreg.ca> <2B1C058D-C304-4E15-ACDA-C3337E67E981@mac.com> <87d5q6pdyv.fsf@evinrude.uhoreg.ca> <42C1A5E8.2040603@slaphack.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1B33F15E-4519-466E-A5B8-F0C652856C57@mac.com>
Cc: Hubert Chan <hubert@uhoreg.ca>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: reiser4 plugins
Date: Tue, 28 Jun 2005 16:03:21 -0400
To: David Masover <ninja@slaphack.com>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2005, at 15:32:56, David Masover wrote:
> Hubert Chan wrote:
>> On Tue, 28 Jun 2005 02:01:12 -0400, Kyle Moffett  
>> <mrmacman_g4@mac.com> said:
>>> I don't disagree with the thumbnail/icon/description, but things  
>>> like
>>> POSIX acls and extended attributes have _existing_ interfaces which
>>> should be used.
>
> Any existing interface should be supported, but Reiser4 seems to  
> want to
> replace all existing interfaces except a direct open() and a proposed
> new system call which opens lots of small files at once, efficiently.
>
> The two approaches are not mutually exclusive, though.

I don't think most kernel developers are likely to favor an approach
which smashes a bunch of unrelated data together.  Linux syscall
overhead is incredibly low, so I don't see it being much of a problem.
On the other hand, a simple syscall which smashes together a bunch of
related data would not be that big of an issue either.  Let's wait for
Namesys to tinker and come back with a new patch before commenting
further.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't.  
That's why
I draw cartoons. It's my life."
-- Charles Shultz

