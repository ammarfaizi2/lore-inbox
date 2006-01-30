Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWA3V53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWA3V53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWA3V53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:57:29 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:12350 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932387AbWA3V52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:57:28 -0500
Message-ID: <43DE8C1B.1050004@tmr.com>
Date: Mon, 30 Jan 2006 16:58:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de, axboe@suse.de,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <20060125182552.GB4212@suse.de> <20060125231422.GB2137@merlin.emma.line.org> <20060126020951.14ebc188.grundig@teleline.es> <20060126082324.GB13125@merlin.emma.line.org> <43D8D50D.nailE2X5WK8ZO@burner>
In-Reply-To: <43D8D50D.nailE2X5WK8ZO@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> 
>>Well, you need to implement 30 (or so) platform-specific ways to get a
>>list of devices, and portable applications aren't going to do that. To
>>make it explicit: no way. It is a maintenance nightmare, 30 lowly-tested
>>pieces of code, too.
> 
> 
> It already works in libscg since nearly 10 years.
> 
> 
>>This sounds like a huge difference, but I don't believe it actually is.
>>Jörg is trying to fight the system rather than stop complaining to users
>>about their using /dev/hd*. The scanning code is there and can be made
>>working with little effort probably.
> 
> 
> Talking about /dev/hd* ignore the basic problem. Show me a way how to
> send SCSI commands to a ATAPI tape drive on Linux. 
> 
> Please do not forget that libscg is OS _and_ device independent.
> Implementing /dev/hd* support at all is already a concession that did go to far.

You added the feature, and a message that it was accidental and 
unsupported. In truth is was neither, and your little message pisses off 
developers and scares casual users.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
