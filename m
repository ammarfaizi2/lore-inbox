Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAIW2T>; Tue, 9 Jan 2001 17:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAIW2J>; Tue, 9 Jan 2001 17:28:09 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:14098 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129406AbRAIW1v>; Tue, 9 Jan 2001 17:27:51 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Linux 2.2.19pre7
Date: 9 Jan 2001 22:27:55 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <93g39b$a9b$1@enterprise.cistron.net>
In-Reply-To: <3A5B6437.3BC23AD3@metabyte.com>
X-Trace: enterprise.cistron.net 979079275 10539 195.64.65.67 (9 Jan 2001 22:27:55 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A5B6437.3BC23AD3@metabyte.com>,
Pete Zaitcev  <zaitcev@metabyte.com> wrote:
>> o Fix kwhich versus old bash (Pete Zaitcev) 
>
>DaveM pointed out that it fixes a non-problem.
>I stepped on a bug with an obscure kernel, I think it
>was 2.2.18-pre3, which called kwhich with several arguments.
>Current kernels call kwhich with one argument at a time,
>so they are not affected.

Yes, but I think it simply puts something right that might be wrong
or at least less portable. So it's correct. Also calling kwhich with
multiple arguments was actually the idea behind the script. Oh well, as
long as it works ...

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
