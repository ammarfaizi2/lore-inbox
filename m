Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbSKCA7Q>; Sat, 2 Nov 2002 19:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSKCA7Q>; Sat, 2 Nov 2002 19:59:16 -0500
Received: from oak.sktc.net ([208.46.69.4]:43214 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S261539AbSKCA7Q>;
	Sat, 2 Nov 2002 19:59:16 -0500
Message-ID: <3DC47659.4060006@sktc.net>
Date: Sat, 02 Nov 2002 19:05:29 -0600
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
References: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
> And pathnames are a _hell_ of a lot better and straightforward interface
> than inode numbers are. It's confusing when you change the permission on
> one path to notice that another path magically changed too.

Would this not allow a user to add permissions to a file, by creating a 
new directory entry and linking it to an existing inode?

Would that not be a greater security hole?

