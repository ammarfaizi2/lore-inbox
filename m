Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285168AbRLRVKn>; Tue, 18 Dec 2001 16:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285177AbRLRVKe>; Tue, 18 Dec 2001 16:10:34 -0500
Received: from [217.9.226.246] ([217.9.226.246]:57728 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S285168AbRLRVKS>; Tue, 18 Dec 2001 16:10:18 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <Pine.LNX.4.21.0112181745240.4473-100000@freak.distro.conectiva>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.21.0112181745240.4473-100000@freak.distro.conectiva>
Date: 18 Dec 2001 22:54:40 +0200
Message-ID: <87bsgwi6zz.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Marcelo" == Marcelo Tosatti <marcelo@conectiva.com.br> writes:

Marcelo> Momchil, 

Marcelo> Your fix does not look right. We _have_ to sync pages at
Marcelo> sync_page_buffers(), we cannot "ignore" them.

Sure, we don't ignore them, we just don't _wait_ for them, because
maybe _we_ are the one to write them.  

Regards,
-velco
