Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbSIZN1p>; Thu, 26 Sep 2002 09:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSIZN1p>; Thu, 26 Sep 2002 09:27:45 -0400
Received: from pop.gmx.de ([213.165.64.20]:64059 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261282AbSIZN1o>;
	Thu, 26 Sep 2002 09:27:44 -0400
Message-ID: <3D930C87.20301@gmx.at>
Date: Thu, 26 Sep 2002 15:32:55 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Arjan van de Ven <arjanv@redhat.com>, Petr Slansky <slansky@usa.net>,
       linux-kernel@vger.kernel.org
Subject: Re: hpt370 raid driver
References: <200209261048.g8QAmfO15438@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>The header files are good. They show the structure of the raid signature 
>>and some info about the event logs. They could be reused by the linux 
>>module, however I do not know if the copyright is a problem there. Does 
>>anyone know...?
> 
> 
> I dont think it shows anything our hptraid module doesnt alreayd know

Oops! You are right. Most of the structures are for internal driver 
stuff. The only useful thing might be the magic numbers and maybe the 
ErrorLog struct, but no raid-signature. :(

Greetings,
Wilfried
-- 
Ing. Wilfried Weissmann               mailto: Wilfried.Weissmann@gmx.at
Benedikt-Schellingergasse 18/19a      Tel.: +43 1 78 64 739
1150 Wien                             Mobil: +43 676 944 44 65

