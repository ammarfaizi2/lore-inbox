Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbSJRCwf>; Thu, 17 Oct 2002 22:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSJRCwf>; Thu, 17 Oct 2002 22:52:35 -0400
Received: from zero.aec.at ([193.170.194.10]:43535 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262815AbSJRCwe>;
	Thu, 17 Oct 2002 22:52:34 -0400
To: "Steven French" <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stress testing cifs filesystem
References: <OFEC9BD9C9.68C35D7B-ON87256C55.00699285@boulder.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: 18 Oct 2002 04:57:25 +0200
In-Reply-To: <OFEC9BD9C9.68C35D7B-ON87256C55.00699285@boulder.ibm.com>
Message-ID: <m3of9so3my.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven French" <sfrench@us.ibm.com> writes:

> current code but plan to.  I would like to find a test that tests more
> esoteric combinations of open flags, multiply opening the same files from
> the same process as well as from multiple processes on both the same and
> different machines.   

Run the LSB test suite on it. It includes most of the old POSIX/Single Unix
test suites, which test quite a lot of things and tends to find obscure
bugs in kernels and file system. It's quite complicated to setup 
unfortunately. You can download it somewhere from the opengroup.org web server.

-Andi
