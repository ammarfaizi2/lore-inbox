Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTLDQKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLDQKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:10:01 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:55557 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S262131AbTLDQJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:09:58 -0500
Message-ID: <3FCF5BB8.50500@lougher.demon.co.uk>
Date: Thu, 04 Dec 2003 16:07:20 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.2.1) Gecko/20030228
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312031600460.2055@home.osdl.org> <20031204141725.GC7890@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312040712270.2055@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312040712270.2055@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
>
> Encryption does have a few extra problems, simply because of the intent.
> In a compressed filesystem it is ok to say "this information tends to be
> small and hard to compress, so let's not" (for example, metadata). While
> in an encrypted filesystem you shouldn't skip the "hard" pieces..

Squashfs is I think the only Linux filesystem that does compress the 
metadata.  I did this more as a technical challenge, but the extra 
compression is sometimes worthwhile, especially with filesystems with 
lots of small files.  Normally, however, it probably isn't worth the effort.

Phillip

> 
> (Encrypted filesystems also have the key management issues, further
> complicating the thing, but that complication tends to be at a higher
> level).
> 
> 		Linus



