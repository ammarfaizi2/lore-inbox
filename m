Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272139AbTHFTvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272141AbTHFTvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:51:00 -0400
Received: from mail.gondor.com ([212.117.64.182]:1549 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S272139AbTHFTu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:50:58 -0400
Date: Wed, 6 Aug 2003 21:50:57 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030806195057.GA8615@gondor.com>
References: <20030806150335.GA5430@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806150335.GA5430@gondor.com>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 05:03:35PM +0200, Jan Niehusmann wrote:
> 3,0,0,0,300,7,0,... (rest are 0s). These blocks start at the following 
> positions:
> 
> 6630000001
> 6638000001
[...]

Small but important correction: make all these positions
6630000000
6638000000
[...]

I was unaware that cmp -l starts counting at 1 instead of 0...

Jan

