Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRJZCzj>; Thu, 25 Oct 2001 22:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRJZCz3>; Thu, 25 Oct 2001 22:55:29 -0400
Received: from mail.direcpc.com ([198.77.116.30]:10958 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S277371AbRJZCzO>; Thu, 25 Oct 2001 22:55:14 -0400
Subject: Re: Other computers HIGHLY degrading network performance (DoS?)
From: "Jeffrey H. Ingber" <jhingber@ix.netcom.com>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011026084328.A14814@bee.lk>
In-Reply-To: <20011026084328.A14814@bee.lk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 25 Oct 2001 22:55:16 -0400
Message-Id: <1004064922.21997.7.camel@Eleusis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is what QoS and the like are for.

Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)

On Thu, 2001-10-25 at 22:43, Anuradha Ratnaweera wrote:
> 
> This is not a direct kernel issse.  However, it is a serious threat for the
> network performance of our Linux boxes, therefore I thought of posting it here.
> 
> There is a popular software that runs on MS platform called "download
> accelerator".  This opens several threads for a download job (each one
> downloading a portion of the file), sometimes even using mirror sites.
> However, it not only grabs whole bandwidth, but makes it hard for other
> machines to even ping each other the return time being around 5-10 seconds on a
> 100 Mbps network!  The download process is getting only 64 kbps from the
> Internet.  Internet access is virtually impossible for the other machines.
> 
> This program can run with a `normal download' mode and this doesn't cause a
> big problem.
> 
> I monitored network traffic with tcpdump, and noticed that those packets don't
> have tcp timestamps and tcp sack.  I turned them off on my Linux box using
> sysctl, and also tried turning on ECN without success.
> 
> This is of course a DoS in disguise, and is there a way to stop it?
> 
> I am thinking of setting up a firewall with netfilter and transparent proxy as
> a workaround.
> 
> Thanks in advance.
> 
> Regards,
> 
> Anuradha
> 
> -- 
> 
> Debian GNU/Linux (kernel 2.4.13)
> 
> History books which contain no lies are extremely dull.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


