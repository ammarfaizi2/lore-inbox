Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270163AbRHMMeG>; Mon, 13 Aug 2001 08:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270158AbRHMMd4>; Mon, 13 Aug 2001 08:33:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27652 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270163AbRHMMdr>; Mon, 13 Aug 2001 08:33:47 -0400
Subject: Re: Linux 2.4.8-ac2
To: hakan.wessberg@it.gu.se.=?ISO-8859-1?Q? (H=E5kan?= Wessberg)
Date: Mon, 13 Aug 2001 13:36:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, laughing@shared-source.org (Alan Cox)
In-Reply-To: <20010813141936.A993@it.gu.se> from =?ISO-8859-1?Q?"H=E5kan?= Wessberg" at Aug 13, 2001 02:19:36 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WGwy-0007Iz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the situation:
> I have a script owned by a non-root user, it's chmod is 700.
> as root I can read the content of the file, but I'm not able to execute
> the script...

Known bug. The -ac stuff fixed a problem with access() and accidentally 
broke other bits od the odd rule about execute. Should be fixed in ac3


