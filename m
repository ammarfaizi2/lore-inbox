Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291164AbSBGPNI>; Thu, 7 Feb 2002 10:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291166AbSBGPMt>; Thu, 7 Feb 2002 10:12:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5248 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291164AbSBGPMi>;
	Thu, 7 Feb 2002 10:12:38 -0500
Date: Thu, 07 Feb 2002 07:10:37 -0800 (PST)
Message-Id: <20020207.071037.74749998.davem@redhat.com>
To: phillips@bonn-fries.net
Cc: riel@conectiva.com.br, Ulrich.Weigand@de.ibm.com, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: The IBM order relaxation patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16Yq9D-0000bD-00@starship.berlin>
In-Reply-To: <Pine.LNX.4.33L.0202071254430.17850-100000@imladris.surriel.com>
	<E16Yq9D-0000bD-00@starship.berlin>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@bonn-fries.net>
   Date: Thu, 7 Feb 2002 16:07:39 +0100
   
   I'd rather see rmap go in in its simplest possible form, outperforming the
   current virtual scanning method on basic page replacement performance, rather 
   that using the other things we know rmap can do as the argument for inclusion.
   It's for this reason that I'm concentrating on the fork speedup.

Ok, but just keep in mind that failing for < 3 order page allocations
would be a regression from what is in there now.
