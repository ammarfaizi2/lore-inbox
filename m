Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTEZS1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTEZS1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:27:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24011
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262031AbTEZS1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:27:38 -0400
Subject: RE: [BUGS] 2.5.69 syncppp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OPENKONOOJPFMJFAJLHAKEPCCBAA.paulkf@microgate.com>
References: <OPENKONOOJPFMJFAJLHAKEPCCBAA.paulkf@microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053970962.16694.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 May 2003 18:42:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-24 at 00:11, Paul Fulghum wrote:
> I thought it was in place to serialize state changes.
> I'll look at it harder, you may be right in that
> it is not necessary.

The state serialization doesn't have to be 100% for PPP however,
you already have the same races present due to wire time so I
also think it should be ok.


