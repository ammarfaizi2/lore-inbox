Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274559AbRIYMak>; Tue, 25 Sep 2001 08:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274438AbRIYMaa>; Tue, 25 Sep 2001 08:30:30 -0400
Received: from mail-01.med.umich.edu ([141.214.93.149]:44492 "HELO
	mail-01.med.umich.edu") by vger.kernel.org with SMTP
	id <S274219AbRIYMaP> convert rfc822-to-8bit; Tue, 25 Sep 2001 08:30:15 -0400
Message-Id: <sbb04129.085@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise 5.5.4
Date: Tue, 25 Sep 2001 08:32:22 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: "<Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Burning a CD image slow down my connection
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi
>
>> Hmm, /dev/cdrom would typically be a link. You might try to apply hdparm
>> to where the link points to, but I cannot really believe hdparm doesn't
>> follow links.
>
>yes it's a link to /dev/scd0 and I CAN mount it, because my IDE cdrom is
>seen as scsi. In lilo.conf I've this line: append="hdd=ide-scsi
>hdc=ide-scsi" (read CD-WRITING HOWTO for more information)

To re-iterate a previous answer, you must run hdparm against '/dev/hdd',  _not_  '/dev/scd0'.





