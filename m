Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270752AbTHJWKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270753AbTHJWKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:10:25 -0400
Received: from mail.gondor.com ([212.117.64.182]:34822 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S270752AbTHJWKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:10:22 -0400
Date: Mon, 11 Aug 2003 00:10:20 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030810221020.GA7832@gondor.com>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com> <20030807211236.GA5637@win.tue.nl> <20030810205513.GA6337@gondor.com> <20030810231955.A16852@pclin040.win.tue.nl> <20030810213450.GA7050@gondor.com> <20030810235834.A16865@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810235834.A16865@pclin040.win.tue.nl>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 11:58:34PM +0200, Andries Brouwer wrote:
> OK. So, this means that you cannot access past the 2^28 sector boundary.
> 
> So, you can address at most 137 GB of your disk.
> 
> Did you say that it was 250 GB?

Exactly. And it's reported as 250GB, and I can access parts of the disk
behind the 137 GB limit without an error message, but it looks like
writing to these parts, it silently overwrites content at the beginning
of the drive. Like it just discards the upper bits of the address or
something like that.

Jan

