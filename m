Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSILPYw>; Thu, 12 Sep 2002 11:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSILPYw>; Thu, 12 Sep 2002 11:24:52 -0400
Received: from ns1.mscsoftware.com ([192.207.69.10]:55291 "EHLO
	draco.macsch.com") by vger.kernel.org with ESMTP id <S316437AbSILPYv> convert rfc822-to-8bit;
	Thu, 12 Sep 2002 11:24:51 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Knoblauch <martin.knoblauch@mscsoftware.com>
Reply-To: martin.knoblauch@mscsoftware.com
Organization: MSC.Software GmbH
To: jbradford@dial.pipex.com
Subject: Re: XFS?
Date: Thu, 12 Sep 2002 17:27:50 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209121727.50745.martin.knoblauch@mscsoftware.com>
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.15.0.1; VDF: 6.15.0.7
	 at mailmuc has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In my opinion the non-inclosure in the mainline kernel is the most 
>> important reason not to use XFS (or any other FS). Which in turn 
>> massively reduces the tester base. It is a shame, because for some 
type 
>> of applications it performs great, or better than anything else. 
>
>
>On the other hand, filesystem corruption bugs are one of the worst type 
>to suffer from. We absolutely don't want to include filesystems 
>without at least a reasonable proven track record in the mainline 
>kernel, and therefore encourage the various distributions to use them, 
>incase any bugs do show up. Look how long a buffer overflow existed in 
>Zlib unnoticed. 
>

 If enclosure in "major" distribuitons defines mainline for you, I have 
to agree. Otherwise, how do you get "a  proven track record in 
mainline" without having it in the mainline kernel ? :-)

 In any case, one could always mark XFS as "experimental" for some time.

>
>EXT2 is a very capable filesystem, and has *years* of proven 
>reliability. That's why I'm not going to switch away from it for 
>critical work any time soon. 

 sure, if you can live with the fsck time on your 200 GB (or bigger) 
filesystem after the occasional crash.

Martin
-- 
Martin Knoblauch
Senior System Architect
MSC.software GmbH
Am Moosfeld 13
D-81829 Muenchen, Germany

e-mail: martin.knoblauch@mscsoftware.com
http://www.mscsoftware.com
Phone/Fax: +49-89-431987-189 / -7189
Mobile: +49-174-3069245

