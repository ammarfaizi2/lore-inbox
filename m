Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271505AbRH1PbL>; Tue, 28 Aug 2001 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271507AbRH1PbB>; Tue, 28 Aug 2001 11:31:01 -0400
Received: from quark.didntduck.org ([216.43.55.190]:46354 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S271505AbRH1Pam>; Tue, 28 Aug 2001 11:30:42 -0400
Message-ID: <3B8BB928.D3AECF73@didntduck.org>
Date: Tue, 28 Aug 2001 11:30:48 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: DOS2linux
In-Reply-To: <001101c12fd0$0fd7f9c0$0100a8c0@kiosks.hospitaladmission.com> <3B8BB2B9.302F6485@pandora.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Vandewoestyne wrote:
> I also found this URL: http://uw7doc.sco.com/cgi-bin/man/man?eisa+D4
> 
> It comes from UnixWare 7 documentation and there they have the kind of
> translation that I want to do (that is: translate INT 15h call "Read
> Function" (AH=D8h, AL=01h)) to linux.  As i understood there isn't
> such thing available for linux?  Meaning I'll have to try and
> implement that stuff myself?  But then the problem remains: how do i
> get to the data that is in the 320 byte buffer returned from an INT
> 15h call "Read Function" (AH=D8h, AL=01h)

Basically, nobody ever implemented an EISA bus layer because it is rare
to see EISA hardware anymore.  The few EISA aware drivers in Linux
handle configuration themselves.  I had thought about doing it at one
time for the sake of completeness, but I don't have access to any EISA
hardware to test.

--

				Brian Gerst
