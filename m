Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136783AbRECMkl>; Thu, 3 May 2001 08:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136788AbRECMkc>; Thu, 3 May 2001 08:40:32 -0400
Received: from www.topmail.de ([212.255.16.226]:59039 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S136783AbRECMkV>;
	Thu, 3 May 2001 08:40:21 -0400
Message-ID: <014a01c0d3ce$3619d440$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Torrey Hoffman" <torrey.hoffman@myrio.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1BA2@mail0.myrio.com>
Subject: Re: [OT] automated remote install of Linux from WinNT4
Date: Thu, 3 May 2001 12:35:27 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd rather create a minimal partition with no (but != &h80) type,
write kind of lilo+kernel+initrd into it and execute that by let
it being called from either the MBR or NTLDR, where you can take
the images' bootsector as a file.
I start lilo from NTLDR 5 by using kind of chaining, which moves
its own code and then loads the MBR of the linux boot partition.
It's so simple that I wrote it in debug. You might wish to use it
when the install's finished.
-mirabilos
-- 
EA F0 FF 00 F0 #$@%CARRIER LOST

