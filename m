Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268657AbRGZTor>; Thu, 26 Jul 2001 15:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268660AbRGZToi>; Thu, 26 Jul 2001 15:44:38 -0400
Received: from mail-out.chello.nl ([213.46.240.7]:56916 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S268657AbRGZToV>; Thu, 26 Jul 2001 15:44:21 -0400
Message-ID: <3B6071F8.5090104@chello.nl>
Date: Thu, 26 Jul 2001 21:39:36 +0200
From: Gerbrand van der Zouw <g.vanderzouw@chello.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon/MSI mobo combo broken?
In-Reply-To: <20010723180201.A10557@convergence.de> <20010723183204.B27310@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

Alan Cox wrote:

> I'd be interested to know if 2.4.6-ac5 Athlon optimised works on your board.
> The reason for this is that it contains the official VIA fixes for their IDE
> corruption problem rather than our own.

I have a MSI K7T Turbo (MS-6330) mobo (VIA-KT133A chipset) and had a go 
with the 2.4.6-ac5 kernel with Athlon optimisations on. The overall 
impression is that the combination is slightly more stable than kernels 
without the Southbridge fix. I.e. I now manage to boot in single user 
mode, however running anything as advanced as gcc is out of the 
question: oopses all over the place and also some complaints from the 
VM-system.

I am in no way qualified enough to go hacking around in the kernel 
myself, but am quite willing to test any patches that might help towards 
solving the problem.

Cheers,

Gerbrand van der Zouw

