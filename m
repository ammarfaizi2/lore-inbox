Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWBQU4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWBQU4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWBQU4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:56:18 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:677 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751787AbWBQU4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:56:18 -0500
Message-ID: <43F63846.80109@tmr.com>
Date: Fri, 17 Feb 2006 15:55:34 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, "D. Hazelton" <dhazelton@enter.net>,
       mrmacman_g4@mac.com, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com> <43EC83EC.nailISD91HRFF@burner> <200602090737.47747.dhazelton@enter.net> <20060210130228.GA30256@infradead.org>
In-Reply-To: <20060210130228.GA30256@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> You can access SCSI CDs using /dev/sr* for burning CDs.  It's backed by the
> same highlevel code as SG_IO on /dev/hd* while the lowerlevel handling is
> done transparently by the scsi midlayer, the same code used by /dev/sg* for
> the below-blocklayer handling.
> 
This may be true if you create your own /dev entries, or are a udev guru 
and can get it to generate the right entries. And if you use ATAPI 
devices it works fine... But with Fedora and SuSE it appears that USB 
devices which appear as SCSI aren't functional. I tested the Fedora 
myself, and after killing udevd and making some entries by hand it 
worked once.

Now if you can access SCSI burners more power to you, with FC4 up to 
recent updates, my one convenient real SCSI device most definitely 
doesn't work, and I havd to fall the system back to Slackware and 2.4 
which was on it before.

Because you know how to get around the problems doesn't really suggest 
that there aren't any.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
