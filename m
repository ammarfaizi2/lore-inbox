Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290868AbSBFWqn>; Wed, 6 Feb 2002 17:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290864AbSBFWqc>; Wed, 6 Feb 2002 17:46:32 -0500
Received: from [209.237.59.50] ([209.237.59.50]:49191 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S290858AbSBFWqP>; Wed, 6 Feb 2002 17:46:15 -0500
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ?????????????????????
In-Reply-To: <0GR400G9IRB2XW@mtaout03.icomcast.net> <2094646627.1013034678@[195.224.237.69]>
From: Roland Dreier <roland@topspincom.com>
Date: 06 Feb 2002 14:46:10 -0800
In-Reply-To: Alex Bligh - linux-kernel's message of "Wed, 06 Feb 2002 22:31:18 -0000"
Message-ID: <52adumkz4d.fsf@love-boat.topspincom.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alex" == Alex Bligh <- linux-kernel <linux-kernel@alex.org.uk>> writes:

    Alex> like Subject: [ANNOUNCE] blah blah?

    Brian> Can we get something like /[\200-\377]{6}/ (6 upper ACSII
    Brian> characters in a row) added to the taboo list?

Brian's pattern doesn't match upper case letters.  It matches
characters with the most significant bit set.  'A' is 0101 octal,
'N' is 0116 octal, etc. so your example would not trigger the rule.
The idea of the rule is to filter out messages posted in non-Roman
character sets.

Roland
