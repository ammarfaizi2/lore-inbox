Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSKHOHc>; Fri, 8 Nov 2002 09:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSKHOHc>; Fri, 8 Nov 2002 09:07:32 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:16888 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262038AbSKHOHb>; Fri, 8 Nov 2002 09:07:31 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3DCBC2E3.5040503@convergence.de> 
References: <3DCBC2E3.5040503@convergence.de>  <28280.1036753951@passion.cambridge.redhat.com> 
To: Holger Waechtler <holger@convergence.de>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Switch DVB to generic crc32. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Nov 2002 14:14:09 +0000
Message-ID: <16466.1036764849@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


holger@convergence.de said:
>  the crc32 table was defined because the same driver works for 2.4
> kernels, there we need our own crc32 implementation.

JFFS2 in 2.4 has the same problem. The fix is to backport the 2.5 crc32 
code so that 2.4 isn't gratuitously different. That patch has been sent to 
Alan already, I believe it's going to be sent to Marcelo for 2.4.21-pre1.

--
dwmw2


