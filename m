Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281308AbRKPLeS>; Fri, 16 Nov 2001 06:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281309AbRKPLeI>; Fri, 16 Nov 2001 06:34:08 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25094 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281308AbRKPLdy>; Fri, 16 Nov 2001 06:33:54 -0500
Date: Fri, 16 Nov 2001 12:33:49 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: infinite loop in 3c509 driver IRQ loop?
Message-ID: <20011116123349.A25438@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011116114902.K5520@emma1.emma.line.org> <E164gpo-0003fJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E164gpo-0003fJ-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Alan Cox wrote:

> It means the card kept having work left to do - eg because it was under
> extreme load at that point. Its not neccessarily a bug - did the box then
> recover ?

Yes, it did. The LAN (twisted pair cabling, 16 bit prefix) contains
several hundred Windows workstations alongside some Linux boxes (in the
same collision domain, that is), so the machine may have been under
severe broadcast load as is common for Windows machines to toss out.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
