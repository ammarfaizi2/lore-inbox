Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291269AbSBVCL2>; Thu, 21 Feb 2002 21:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291272AbSBVCLJ>; Thu, 21 Feb 2002 21:11:09 -0500
Received: from mail.myrio.com ([63.109.146.2]:12785 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S291269AbSBVCLH> convert rfc822-to-8bit;
	Thu, 21 Feb 2002 21:11:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: boot messeage
Date: Thu, 21 Feb 2002 18:09:32 -0800
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3B2@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: boot messeage
Thread-Index: AcG7QuIpFt6qR7loRnm4bfxSAMFlcwAAdsmA
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: "Pozsar Balazs" <pozsy@sch.bme.hu>,
        "hanhbkernel" <hanhbkernel@yahoo.com.cn>,
        <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Feb 2002 02:10:27.0203 (UTC) FILETIME=[183FE530:01C1BB46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 21, 2002 at 05:34:00PM -0800, Torrey Hoffman wrote:
> > Then use append="console=/dev/tty2 CONSOLE=/dev/tty2", and you won't
> 
> Why do you use both console and CONSOLE?

hmmm.  I can't really remember, but I'm pretty sure it was necessary 
when I started doing this 18 months ago, I wouldn't have added it 
otherwise.

IIRC, "CONSOLE=/dev/tty2" becomes an environment variable for init, and 
with the right intelligence in your startup scripts you get all your rc 
script output on tty2 as well.  On the other hand, my current startup 
scripts don't seem to use it or need it...   so I guess I don't know.

cargo-cult system management :-(   ("but I've always done it that way")

Torrey



