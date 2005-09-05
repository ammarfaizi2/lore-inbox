Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVIENR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVIENR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVIENR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:17:57 -0400
Received: from web8509.mail.in.yahoo.com ([202.43.219.171]:16473 "HELO
	web8509.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1751249AbVIENR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:17:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NBD1LNe2NMBoAL7vNO6k8W+HnIIEkV6yppvj5z9P9NxYQo5h0XoilU+fRB5ACU+HIrtp3HoBUjUbNmV8u199qLRXxSz4fWACF78WRjBdKibnguV3S5agbl+y6Uyg5J4+e2GjbnuXwSpiPWKCLUC98jwDUN/npCnln5gEEa8yA8w=  ;
Message-ID: <20050905131746.11900.qmail@web8509.mail.in.yahoo.com>
Date: Mon, 5 Sep 2005 14:17:46 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: netif_rx for ATM
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am writing a new driver module for ATM. I want to
send a packet to protocol stack using netif_rx(). For
ethernet i am using netif_rx() in the following way. I
have dev pointer.

  skbuff->dev = device; 
  skbuff->protocol = eth_type_trans(skbuff, device); 
  netif_rx(skbuff); 

It works for ethernet and POS and does not work for
ATM. Could anyone please tell me what to do for ATM?

Regards,
Mano


Manomugdha Biswas


	

	
		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner online. Go to http://yahoo.shaadi.com
