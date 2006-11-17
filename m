Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932901AbWKQOMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbWKQOMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbWKQOMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:12:32 -0500
Received: from web23105.mail.ird.yahoo.com ([217.146.189.45]:36006 "HELO
	web23105.mail.ird.yahoo.com") by vger.kernel.org with SMTP
	id S932901AbWKQOMb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:12:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wXT/0SelTy6/07wt+l9rwTi9XKOCo6yx4H2WAkELq490DFwmO9FNv5RzrIdnSBXDoeENwBW7URw5o4pPNNuE0NhwLh71Qxj2ngmIJQ9mcN9vtWp13hgGBmZ41qMQuwCH8QJDQQxGNiGZv3RXtnT7k1cJrI5v4p74KxNas8qnv5Q=  ;
Message-ID: <20061117141230.70698.qmail@web23105.mail.ird.yahoo.com>
Date: Fri, 17 Nov 2006 14:12:30 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : vm: weird behaviour when munmapping
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> No indeed. You seem confused with remaining and new. 
> 
> It has one VMA (A) it needs to split that into two pieces, it happens to
> do it like (B,A') where A' is the old VMA object with new a start
> address, and B is a new VMA object.

Is there any rules to decide which VMA is the new one ? 

>From what you wrote it seems that we call B the new object because
it has a new end address...

>From my point of view, I called B the old VMA simply because it's
going to be destroyed...

Francis





	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com
