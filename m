Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUJVTo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUJVTo3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUJVTly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:41:54 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:16263 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267251AbUJVTjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:39:08 -0400
Date: Fri, 22 Oct 2004 21:35:54 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: Andrew Morton <akpm@osdl.org>, xhejtman@mail.muni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed
Message-ID: <20041022193554.GA4216@electric-eye.fr.zoreil.com>
References: <2E314DE03538984BA5634F12115B3A4E01BC3FA5@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC3FA5@email1.mitretek.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piszcz, Justin Michael <justin.piszcz@mitretek.org> :
[...]
> I found this in regards to TSO:
> http://www.kerneltrap.org/node.php?id=397
> 
> Which option enables TSO?

It is included in the IP stack and depends on the ability of your hardware.
'ethtool -K ethX tso on' should activate it. See 'man 8 ethtool' for details.

This question would probably be more accurate on netdev@oss.sgi.com.

--
Ueimor
