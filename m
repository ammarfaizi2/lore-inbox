Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTJ0Ssw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTJ0Ssw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:48:52 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:38116 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263462AbTJ0Ssv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:48:51 -0500
Message-ID: <3F9D6891.5040300@namesys.com>
Date: Mon, 27 Oct 2003 21:48:49 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
CC: "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results get worse
References: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com>
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mudama, Eric wrote:

>
> or put it under heavy write workload and remove
>power.
>
Can you tell us more about what really happens to disk drives when the 
power is cut while a block is being written?  We engage in a lot of 
uninformed speculation, and it would be nice if someone who really knows 
told us....

Do drives have enough capacitance under normal conditions to finish 
writing the block?  Does ECC on the drive detect that the block was bad 
and so we don't need to detect it in the FS?

-- 
Hans


