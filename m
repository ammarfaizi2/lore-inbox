Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285254AbRLFXJs>; Thu, 6 Dec 2001 18:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285280AbRLFXJi>; Thu, 6 Dec 2001 18:09:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32908 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285254AbRLFXJ2>;
	Thu, 6 Dec 2001 18:09:28 -0500
Date: Thu, 06 Dec 2001 15:08:47 -0800 (PST)
Message-Id: <20011206.150847.45874365.davem@redhat.com>
To: bcrl@redhat.com
Cc: lm@bitmover.com, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206172708.B31752@redhat.com>
In-Reply-To: <20011206122116.H27589@work.bitmover.com>
	<20011206.130202.107681970.davem@redhat.com>
	<20011206172708.B31752@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Thu, 6 Dec 2001 17:27:08 -0500

   	- lower overhead for SMP systems.  We can use UP kernels local 
   	  to each CPU.  Should make kernel compiles faster. ;-)
   
Actually, this isn't what is being proposed.  Something like
"4 cpu" SMP kernels.

   At the very least it is well worth investigating.  Bootstrapping the 
   ccCluster work shouldn't take more than a week or so, which will let 
   us attach some hard numbers to the kind of impact it has on purely 
   cpu local tasks.
   
I think it is worth considering too, but I don't know if a week
estimate is sane or not :-)
