Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSLTOWr>; Fri, 20 Dec 2002 09:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSLTOWr>; Fri, 20 Dec 2002 09:22:47 -0500
Received: from mailb.telia.com ([194.22.194.6]:193 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S262303AbSLTOWq> convert rfc822-to-8bit;
	Fri, 20 Dec 2002 09:22:46 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Torben Frey <kernel@mailsammler.de>
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Date: Fri, 20 Dec 2002 15:27:16 +0100
User-Agent: KMail/1.5
References: <3E01D7D7.2070201@mailsammler.de>
In-Reply-To: <3E01D7D7.2070201@mailsammler.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200212201527.16812.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 December 2002 15:29, Torben Frey wrote:
> 2 0 4 25292 2292 72056 759548 0 0 30404 20084 820 1149 4 85 11
> 0 1 3 25292 2828 72048 759012 0 0 40716 23772 845 1307 2 62 36
> 0 1 2 25292 3208 72280 758372 0 0 0 16532 573 231 6 13 81
> 1 0 2 25292 3216 72276 758404 0 0 4880 23800 530 264 2 10 88
> 

Hmm... No process running but still lots of CPU used.
Are you sure that you run the disks with DMA?

You should also try to take a profile of a run.
(see
 man readprofile
and
 linux/Documentation/kernel-parameters.txt
 profile=2 as a boot option should do)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

