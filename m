Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRATW32>; Sat, 20 Jan 2001 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbRATW3T>; Sat, 20 Jan 2001 17:29:19 -0500
Received: from Cantor.suse.de ([194.112.123.193]:10000 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130324AbRATW3D>;
	Sat, 20 Jan 2001 17:29:03 -0500
Date: Sat, 20 Jan 2001 23:28:51 +0100
From: Andi Kleen <ak@suse.de>
To: Sandy Harris <sandy@storm.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: md= broken. Found problem. Can't fix it.  : (
Message-ID: <20010120232851.A10166@gruyere.muc.suse.de>
In-Reply-To: <3A6A044F.7974AF67@psychosis.com> <3A6A0A20.18362B90@storm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A6A0A20.18362B90@storm.ca>; from sandy@storm.ca on Sat, Jan 20, 2001 at 04:58:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 04:58:56PM -0500, Sandy Harris wrote:
> I suspect that I've misunderstood some constraint here. Perhaps the more complex
> code you posted is necessary, but I'd like to know why.

strtok is not reentrant and cannot be nested this way without 
saving __strtok. strsep would work.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
