Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTENOth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTENOth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:49:37 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:43208 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262371AbTENOtg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:49:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "ismail donmez" <kde@smtp-send.myrealbox.com>, gutko@poczta.onet.pl
Subject: Re: supermount
Date: Thu, 15 May 2003 01:04:23 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <1052919631.273b9220kde@smtp-send.myrealbox.com>
In-Reply-To: <1052919631.273b9220kde@smtp-send.myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305150104.23616.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003 23:40, ismail donmez wrote:
> Yeah I wonder the same for some time . Is there a good reason not to
> include supermount in kernel?
>
> -----Original Message-----
> From: Maciej Górnicki <gutko@poczta.onet.pl>
> To: linux-kernel@vger.kernel.org
> Date: Tue, 13 May 2003 18:30:02 +0200
> Subject: supermount
>
> Hello,
> Why supermount code is not included in kernel?
> It's maintained by Juan Jose Quintela from Mandrake...

Watch this space. There's some work happening with 2.4 bug testing with some 
supermount development work and then 2.5 will follow soon enough. The current 
version (call it a fork?) of 1.2.5 has a problem with filesystems that can 
write the same file with different case (eg vfat writing file.c and File.c) 
but can be found at the new sourceforge home:
http://supermount-ng.sf.net
A bugfix for that known bug should be available soon and then it will need 
lots more testing...
Con
