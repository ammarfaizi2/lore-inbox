Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUHRRzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUHRRzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 13:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267395AbUHRRzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 13:55:39 -0400
Received: from the-village.bc.nu ([81.2.110.252]:9344 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267389AbUHRRzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 13:55:32 -0400
Subject: RE: Serial Driver for PPP - that runs in Half Duplex Mode
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "vanitha@agilis.st.com.sg" <vanitha@agilis.st.com.sg>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <01C48517.98874380.vanitha@agilis.st.com.sg>
References: <01C48517.98874380.vanitha@agilis.st.com.sg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092847985.26056.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 18 Aug 2004 17:53:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-18 at 12:36, Vanitha Ramaswami wrote:
> Hello,
>     Thanks for your mail. Can you let me know what are the other protocols that performs better than PPP ?

That will depend upon your link quality. If you drop a lot of frames
then a link layer reliable protocol or FEC based protocol will do
better. We used AX.25 (LAP-B with addressing). On radios that do their
own reliability/error handling IP is often just fine (as with 802.11)

