Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSDWMpt>; Tue, 23 Apr 2002 08:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315194AbSDWMps>; Tue, 23 Apr 2002 08:45:48 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:31986 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315192AbSDWMps>; Tue, 23 Apr 2002 08:45:48 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <UTC200204222031.g3MKVZq07564.aeb@smtp.cwi.nl> 
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        mdharm-usb@one-eyed-alien.net
Subject: Re: Flash device IDs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 13:45:42 +0100
Message-ID: <25728.1019565942@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries.Brouwer@cwi.nl said:
>  No, I am afraid this thing doesn't let me talk to raw flash, or if it
> does, I have not yet discovered how. 

Ok... so when you issue write commands, you're pretending it's a normal 
SCSI hard drive and issuing requests with the _logical_ block numbers? You 
don't have to grok the SmartMedia format and issue _physical_ addresses on 
the flash, handle ECC, the block chains, etc.?

--
dwmw2


