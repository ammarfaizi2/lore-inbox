Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTJZLBf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbTJZLBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:01:34 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:9358 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262887AbTJZLBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:01:33 -0500
Message-ID: <3F9BA98B.20408@namesys.com>
Date: Sun, 26 Oct 2003 14:01:31 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norman Diamond <ndiamond@wta.att.ne.jp>
CC: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results end
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60>
In-Reply-To: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond wrote:

>The drive finally reallocated the block and there are no longer any visible
>bad blocks.
>
>I will not be able to perform the following planned test:
>  Well, in a future weekend, I will try to see if ext2fs really takes action
>  on permanently bad blocks that are detected during normal operations on a
>  mounted partition.
>
>But I think the underlying defects remain in need of correction.  Toshiba
>knows about theirs but will probably never say if they make any fixes.  Mr.
>Reiser and friends have plans to add important features, and I am unable to
>detect if ext2fs needs it.  (As mentioned before, I understand that ext2fs
>can do it during formatting and fsck, but no one seems to be saying what
>happens if a permanently bad block is detected during normal operation on a
>mounted partition.)
>
>
>
>  
>
Badblocks support is in reiser4, and anyone is welcome to update the 
patch for V3, or sponsor us to do it.  We are very low on cash, so we 
only work on V4, as that is the only way it will get to ship.

-- 
Hans


