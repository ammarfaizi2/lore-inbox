Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSAQBIQ>; Wed, 16 Jan 2002 20:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287571AbSAQBIG>; Wed, 16 Jan 2002 20:08:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47234 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287421AbSAQBH4>;
	Wed, 16 Jan 2002 20:07:56 -0500
Date: Wed, 16 Jan 2002 17:06:52 -0800 (PST)
Message-Id: <20020116.170652.58455989.davem@redhat.com>
To: COHUCK@de.ibm.com
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCHLET] Tiny fixes for fastrouting
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF58C79499.EC73CC6E-ONC1256B43.00542D7F@de.ibm.com>
In-Reply-To: <OF58C79499.EC73CC6E-ONC1256B43.00542D7F@de.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Cornelia Huck" <COHUCK@de.ibm.com>
   Date: Wed, 16 Jan 2002 16:57:27 +0100

I've applied your patches, thanks.  But PLEASE!
In the future use a mailer that does not undo tab
characters, I could not apply your patch as-is I had
to hand apply it because:

   -    if (pt->data) {
   +    if ((pt->data) && ((int)(pt->data)!=1)) {

had the said corruption.
