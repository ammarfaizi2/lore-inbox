Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTEAMyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 08:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbTEAMyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 08:54:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22424
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261245AbTEAMyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 08:54:20 -0400
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Backlund <tmb@iki.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b8r26l$he0$1@main.gmane.org>
References: <3EB0413D.2050200@superonline.com> <b8r26l$he0$1@main.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051790876.21546.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 13:07:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-01 at 13:00, Thomas Backlund wrote:
> but there are programs that benefits from the "extra" memory...
> this according to Antonino Daplas...
> (AFAIK double/triple buffering is one thing...)

I've actually looke through the traces  for some situations
and the "how much memory" case is reporting banked RAM on some 
cards so you don't know that RAM exists.

The change proposed is definitely correct for the default. Whether
you want to support overriding it I don't know - I'm not worried
either way.

