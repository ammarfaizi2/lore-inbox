Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129671AbQKOVUB>; Wed, 15 Nov 2000 16:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQKOVTv>; Wed, 15 Nov 2000 16:19:51 -0500
Received: from unknown-51-46.wrs.com ([147.11.51.46]:53772 "HELO
	Whinham.wrs.com") by vger.kernel.org with SMTP id <S129671AbQKOVTg>;
	Wed, 15 Nov 2000 16:19:36 -0500
Date: Wed, 15 Nov 2000 12:49:32 -0800
From: Michel LESPINASSE <walken@zoy.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test11-pre5 breaks vmware
Message-ID: <20001115124931.B28499@windriver.com>
In-Reply-To: <CF021B54DF0@vcnet.vc.cvut.cz> <Pine.LNX.4.21.0011151454590.10690-100000@godzilla.spiteful.org> <8uuqmv$el4$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8uuqmv$el4$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Nov 15, 2000 at 12:12:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 12:12:15PM -0800, H. Peter Anvin wrote:
> Also, if a piece of software needs raw CPUID information (unlike the
> "cooked" one provided by recent kernels) it should use
> /dev/cpu/*/cpuid.

Is it also OK to use the cpuid opcode in userspace ? (after checking
for its presence with the 0x200000 eflags bit)

-- 
Michel "Walken" LESPINASSE
Of course I think I'm right. If I thought I was wrong, I'd change my mind.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
