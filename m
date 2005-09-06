Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVIFEQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVIFEQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 00:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVIFEQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 00:16:22 -0400
Received: from web8505.mail.in.yahoo.com ([202.43.219.167]:9066 "HELO
	web8505.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1751081AbVIFEQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 00:16:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5sn+zBX677ARo8NKFIj8vFmgb5TY/K3XV/1MLSWJNgpO2Z0fcFKcLoUGWhGO8okD1MLCj/GzmyLzqvHAzm0MJqsPLOKMIIvjUsy9plMjKWevEEcNhGPY/nORRled+7fHH/WRf3XmXQNHaa0D0AccZw5QeBFpGnftQI4+187qh/c=  ;
Message-ID: <20050906041604.50601.qmail@web8505.mail.in.yahoo.com>
Date: Tue, 6 Sep 2005 05:16:04 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: netif_rx for ATM
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
In-Reply-To: <20050905131746.11900.qmail@web8509.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Hi,
 I am writing a new driver module for ATM. I want to
 send a packet to protocol stack using netif_rx().
 For
 ethernet i am using netif_rx() in the following way.
 I
 have dev pointer.
 
   skbuff->dev = device; 
   skbuff->protocol = eth_type_trans(skbuff, device);
 
   netif_rx(skbuff); 
 
 It works for ethernet and POS and does not work for
 ATM. Could anyone please tell me what to do for ATM?
 
 Regards,
 Mano
 
 
> Manomugdha Biswas
> 
> 
> 	
> 
> 	
> 		
>
__________________________________________________________
> 
> Yahoo! India Matrimony: Find your partner online. Go
> to http://yahoo.shaadi.com
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Manomugdha Biswas


	

	
		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner online. Go to http://yahoo.shaadi.com
