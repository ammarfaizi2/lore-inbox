Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275000AbTHLDnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 23:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275003AbTHLDnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 23:43:03 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:11664
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275000AbTHLDnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 23:43:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Mikkelborg <andreas.mikkelborg@hjemme.no>,
       linux-kernel@vger.kernel.org
Subject: Re: Error in videodev.c with 2.6.0-test3-mm1.
Date: Tue, 12 Aug 2003 13:48:34 +1000
User-Agent: KMail/1.5.3
References: <20030812053244.47252991.andreas.mikkelborg@hjemme.no>
In-Reply-To: <20030812053244.47252991.andreas.mikkelborg@hjemme.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121348.34987.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 13:32, Andreas Mikkelborg wrote:
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CC [M]  drivers/media/video/videodev.o
> drivers/media/video/videodev.c:398: `video_proc_entry' undeclared here (not

An earlier bug report said just delete that line. I did and it works fine now.

Con

