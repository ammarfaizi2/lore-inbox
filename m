Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284669AbSADVtY>; Fri, 4 Jan 2002 16:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbSADVtM>; Fri, 4 Jan 2002 16:49:12 -0500
Received: from [217.9.226.246] ([217.9.226.246]:13696 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S284669AbSADVtF>; Fri, 4 Jan 2002 16:49:05 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, mjc@kernel.org,
        bcrl@redhat.com
Subject: Re: hashed waitqueues
In-Reply-To: <20020104094049.A10326@holomorphy.com>
From: Momchil Velikov <velco@fadata.bg>
Date: 04 Jan 2002 23:47:40 +0200
In-Reply-To: <20020104094049.A10326@holomorphy.com>
Message-ID: <87sn9lkcub.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "WLI" == William Lee Irwin <wli@holomorphy.com> writes:

WLI> This is a long-discussed space optimization for the VM system, with

WLI> Cheers,

Cheers ;)

I couple of places that need fixing:

./drivers/char/agp/agpgart_be.c:833:	wake_up(&page->wait);
./drivers/char/agp/agpgart_be.c:2760:	wake_up(&page->wait);
./drivers/char/drm/i810_dma.c:302:	wake_up(&virt_to_page(page)->wait);

Regards,
-velco
