Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbTDZQrm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTDZQrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:47:42 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:33040 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262549AbTDZQrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:47:41 -0400
Date: Sat, 26 Apr 2003 18:59:52 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 NFS file corruption
In-Reply-To: <shsadedrywz.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0304261857450.18264-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond!

Thanks for the quick reply!

On 26 Apr 2003, Trond Myklebust wrote:

> You are updating an executable while the clients are running it??? 
> Bad! That is not meant to work...
> 
It seems to work 50% of the time, while in the other cases every page but the 
first ist correctly updated. Is there a reason why this should be so?

Would it be okay to delete the file and recreate one with the same name? This 
way it should get a new handle, right?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

"If you think NT is the answer, you didn't understand the question."
						- Paul Stephens

