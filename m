Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315796AbSENQUX>; Tue, 14 May 2002 12:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315797AbSENQUW>; Tue, 14 May 2002 12:20:22 -0400
Received: from ns.suse.de ([213.95.15.193]:28421 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315796AbSENQUV>;
	Tue, 14 May 2002 12:20:21 -0400
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: File open/create attibutes.
In-Reply-To: <Pine.LNX.3.95.1020514113724.2711A-100000@chaos.analogic.com>
X-Yow: FISH-NET-FISH-NET-FISH-NET-FISH-NET-FISH!!
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 14 May 2002 18:20:15 +0200
Message-ID: <jeznz23dmo.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

|> Hello,
|> 
|> If a file exists with attributes, 0644, and it is opened with truncate
|> and create with different attributes, it doesn't get those attributes.
|> It's only if the file doesn't exist at all that it gets created with
|> the new attributes.
|> 
|> I think this is a bug.

POSIX disagrees:

O_CREAT         If the file exists, this flag has no effect except as
                noted under O_EXCL below.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
