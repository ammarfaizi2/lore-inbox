Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313736AbSDPQBR>; Tue, 16 Apr 2002 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313732AbSDPQAp>; Tue, 16 Apr 2002 12:00:45 -0400
Received: from c2ce9fba.adsl.oleane.fr ([194.206.159.186]:18090 "EHLO
	avalon.france.sdesigns.com") by vger.kernel.org with ESMTP
	id <S313734AbSDPQAT>; Tue, 16 Apr 2002 12:00:19 -0400
To: linux-kernel@vger.kernel.org
Subject: periodic scsi hard disk noise due to regular flushes?
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 16 Apr 2002 18:00:17 +0200
Message-ID: <7wbscjvdke.fsf@avalon.france.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my recent IBM SCSI drive (18GB IC35L018UWD210-0) connected
to an old Adaptec AHA-2940 UW adapter make as very 
irritating high pitched noise (as if it were parking/unparking
his heads?) periodically with the following intervals:

1min35
2min12
5min03
2min14
1min02
4min09
4min14
3min18
1min06
1min04

It runs in ext3, journalling has commit interval set to 5sec.

Does something happen in the kernel with a about 1min05 interval?

Is there some way to keep it busy?

My kernel is 2.4.7-10

Thanks for any reply to this strange request ;-)

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
