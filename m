Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTJ0TsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTJ0TsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:48:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3521 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263500AbTJ0TsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:48:10 -0500
Message-ID: <3F9D7666.6010504@pobox.com>
Date: Mon, 27 Oct 2003 14:47:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results get worse
References: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com> <3F9D6891.5040300@namesys.com>
In-Reply-To: <3F9D6891.5040300@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Mudama, Eric wrote:
> 
>>
>> or put it under heavy write workload and remove
>> power.
>>
> Can you tell us more about what really happens to disk drives when the 
> power is cut while a block is being written?  We engage in a lot of 
> uninformed speculation, and it would be nice if someone who really knows 
> told us....
> 
> Do drives have enough capacitance under normal conditions to finish 
> writing the block?  Does ECC on the drive detect that the block was bad 
> and so we don't need to detect it in the FS?


Does it really matter to speculate about this?

If you don't FLUSH CACHE, you have no guarantees your data is on the 
platter.

	Jeff



