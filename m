Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317401AbSGOJWo>; Mon, 15 Jul 2002 05:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSGOJWn>; Mon, 15 Jul 2002 05:22:43 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:14750 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317401AbSGOJWl>; Mon, 15 Jul 2002 05:22:41 -0400
Date: Mon, 15 Jul 2002 11:25:02 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][Patch] DMA for CD-ROM audio
Message-Id: <20020715112502.2ce65300.kristian.peters@korseby.net>
In-Reply-To: <1026678886.1244.417.camel@sinai>
References: <20020714113341.786b3600.kristian.peters@korseby.net>
	<1026678886.1244.417.camel@sinai>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-rc1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
> If the code is truly safe on older systems, what I think makes more
> sense is merging it without a configure option and having DMA-capable
> systems use DMA CD-audio and older systems fall back to PIO.

Yes. But it seems that no maintainer is interested. So I thought it could be nice if the user can trigger dma for cd audio.

> This would clean up all those nasty ifdefs and perhaps we could
> generalize the two codepaths together, further reducing size.
> 
> I like the patch... up for my idea for 2.5?

Ok. I port it to 2.5 but that could take some time. The ide layer has changed a bit.

> I wonder what akpm thinks..

He's ok with it. It was he who suggested sending it to the list.

*Kristian
