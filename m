Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285344AbRLFWfE>; Thu, 6 Dec 2001 17:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285265AbRLFWcQ>; Thu, 6 Dec 2001 17:32:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53522 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285275AbRLFWcF>; Thu, 6 Dec 2001 17:32:05 -0500
Subject: Re: Linux/Pro  -- clusters
To: kaih@khms.westfalen.de (Kai Henningsen)
Date: Thu, 6 Dec 2001 22:40:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com
In-Reply-To: <8EK0gp-1w-B@khms.westfalen.de> from "Kai Henningsen" at Dec 06, 2001 08:12:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C7C0-0003M1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cludging a utility to patch a running kernel (don't ask) to increase that  
> timeout. Turned out the drive needed a little over three hours to tell me  
> it couldn't format.
> 
> Frankly, format should really have NO timeout. Or possibly a user- 
> specified one.

For generic packet interfaces the "abort" operation becomes something you
can put in the hands of user space, as well as progress reports
