Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWH0Uxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWH0Uxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWH0Uxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 16:53:44 -0400
Received: from smtpout.mac.com ([17.250.248.171]:31699 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751181AbWH0Uxo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 16:53:44 -0400
In-Reply-To: <20060827201648.GA8845@wohnheim.fh-wedel.de>
References: <20060827171728.GB3502@wohnheim.fh-wedel.de> <20060827181245.GA14544@gen.formicary.org> <20060827201648.GA8845@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <49D5FD4D-4DEC-48CB-B097-D8FD113EA542@mac.com>
Cc: Ian Lindsay <iml@formicary.org>, fsdevel@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: LogFS
Date: Sun, 27 Aug 2006 16:53:14 -0400
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 27, 2006, at 16:16:48, Jörn Engel wrote:
> On Sun, 27 August 2006 14:12:45 -0400, Ian Lindsay wrote:
>>
>> So, 28 should be enough for everyone?
>
> No, it just took me more prodding to notice my thinko.  Thank you  
> for noticing, the bloody bug is fixed now.
>
> Btw, isn't 2^30 32 rather than 28?

Not really. 30 already has the 2 bit set:
   30 = 0b11110 = 16 + 8 + 4 + 2 + 0
   28 = 0b11100 = 16 + 8 + 4 + 0 + 0

Feel free to run this in a terminal to check: :-)
   perl -e 'print( (30^2) ."\n" );'

Cheers,
Kyle Moffett

